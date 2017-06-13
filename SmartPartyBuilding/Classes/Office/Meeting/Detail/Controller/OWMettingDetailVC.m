//
//  OWMettingDetailVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/20.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <MJPhoto.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import <MJPhotoBrowser.h>
#import <SDCycleScrollView.h>
#import "OWMettingDetailVC.h"
#import "OWMeetingDetailCell.h"
#import "OWHomeTitleCell.h"
#import "OWMeetingDateCell.h"
#import "OWMeetingOrderCell.h"
#import "OWMettingOrderVC.h"
#import "OWMeeting.h"
#import "OWRefreshGifHeader.h"
#import "OWNetworking.h"
#import "OWMeetOrder.h"
#import "OWMeetOrderDate.h"

@interface OWMettingDetailVC ()<SDCycleScrollViewDelegate>

@property (nonatomic, weak) SDCycleScrollView *banner;
@property (nonatomic, strong) NSArray *bannerList;
@property (nonatomic, strong) NSArray *detailList;
@property (nonatomic, strong) NSMutableArray *orderlList;

@end

@implementation OWMettingDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"详情";
    
    [self setupTableView];
    [self setupNavi];
    [self setupBanner];
    [self setupRefresh];
}



/** 设置tableview */
- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.detailList = @[
                        @{@"title":@"会议室名称 :",@"content":self.meet.name},
                        @{@"title":@"容纳人员 :",@"content":[NSString stringWithFormat:@"%d人",self.meet.capacity ?: 0]},
                        @{@"title":@"位置 :",@"content":self.meet.location ?: @""},
                        @{@"title":@"管理员 :",@"content":self.meet.manager ?: @""},
                        @{@"title":@"联系电话 :",@"content":self.meet.phone ?: @""}
                        ];
}

- (void)setupNavi
{
    wh_weakSelf(self);
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem wh_itemWithType:WHItemTypeRight norTitle:@"预约" font:14 norColor:wh_RGB(9, 131, 216) highColor:[UIColor blueColor] offset:0 actionHandler:^(UIButton *sender) {
        OWMettingOrderVC *orderVC = [[OWMettingOrderVC alloc] init];
        [weakself.navigationController pushViewController:orderVC animated:YES];
    }];
}


- (void)setupRefresh
{
    wh_weakSelf(self);
    self.tableView.mj_header = [OWRefreshGifHeader headerWithRefreshingBlock:^{
        [weakself dataRequest];
    }];
    [self.tableView.mj_header beginRefreshing];
}


- (void)dataRequest
{
    NSDictionary *par = @{
                          @"page":@"1",
                          @"rows":@"20"
                          };
    [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/meetingRoomOrder/allApply") parameters:par success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            NSDictionary *dataDic = responseObject[@"data"];
            NSMutableArray *mutableList = [NSMutableArray array];
            [dataDic wh_each:^(id key, id obj) {
                NSDictionary *dic = @{
                                      @"date":key,
                                      @"orders":obj
                                      };
                [mutableList addObject:dic];
                
            }];
            self.orderlList = [OWMeetOrderDate mj_objectArrayWithKeyValuesArray:mutableList];
            wh_Log(@"---%@",self.orderlList);
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
        }
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
        [self.tableView.mj_header endRefreshing];
    }];
}


/** 设置轮播图 */
- (void)setupBanner
{
    self.bannerList = [self.meet.imgs componentsSeparatedByString:@","];
    self.banner.imageURLStringsGroup = self.bannerList;
}

#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.orderlList.count + 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }else if (section == 1){
        return 1;
    }else{
        if (self.orderlList.count) {
            OWMeetOrderDate *date = self.orderlList[section - 2];
            return date.orders.count + 1;
        }else{
            return 1;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 25.0f;
    }else if (indexPath.section == 1){
        return 30.0f;
    }else{
        if (indexPath.row == 0) {
            return 30.0f;
        }else{
            return 80.0f;
        }
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (section < 2) ? 10.0f : CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        OWMeetingDetailCell *cell = [OWMeetingDetailCell cellWithTableView:tableView];
        cell.detailDic = self.detailList[indexPath.row];
        return cell;
    }else if (indexPath.section == 1){
        OWHomeTitleCell *cell = [OWHomeTitleCell cellWithTableView:tableView];
        cell.titleDic = @{@"image":@"",@"title":@"预约列表"};
        return cell;
    }else{
        
        OWMeetOrderDate *date = self.orderlList[indexPath.section - 2];
        
        if (indexPath.row == 0){
            OWMeetingDateCell *cell = [OWMeetingDateCell cellWithTableView:tableView];
            cell.title = date.date;
            return cell;
        }else{
            OWMeetingOrderCell *cell = [OWMeetingOrderCell cellWithTableView:tableView];
            cell.meetOrder = date.orders[indexPath.row - 1];
            return cell;
        }
        
    }
}

#pragma mark - ---------- SDCycleScrollViewDelegate ----------

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    NSMutableArray *photos = [NSMutableArray array];
    
    if (self.bannerList.count > 1) {
        
        for (int i=0; i<self.bannerList.count; i++) {
            MJPhoto *photo = [[MJPhoto alloc] init];
            
            id img = [self.bannerList objectAtIndex:i];
            if ([img isKindOfClass:[UIImage class]]) {
                photo.image = img;
            }else{
                photo.url = [NSURL URLWithString:[self.bannerList objectAtIndex:i]];
            }
            photo.srcImageView = [[UIImageView alloc] initWithImage:wh_imageNamed(@"")];
            photo.srcImageView = nil;
            [photos addObject:photo];
        }
        
    }else{
        MJPhoto *photo = [[MJPhoto alloc] init];
        id img = [self.bannerList objectAtIndex:0];
        if ([img isKindOfClass:[UIImage class]]) {
            photo.image = img;
        }else{
            photo.url = [NSURL URLWithString:[self.bannerList objectAtIndex:0]];
        }
        
        photo.srcImageView = [[UIImageView alloc] initWithImage:wh_imageNamed(@"")];;
        [photos addObject:photo];
        
    }
    
    
    browser.photos = photos;
    browser.currentPhotoIndex = index;
    
    [browser show];
}

#pragma mark - ---------- Lazy ----------
- (SDCycleScrollView *)banner
{
    if (!_banner) {
        SDCycleScrollView *banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, wh_screenWidth, 0.488*wh_screenWidth) delegate:self placeholderImage:wh_imageNamed(@"")];
        banner.currentPageDotColor = [UIColor redColor];
        banner.autoScroll = NO;;
        banner.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
        banner.placeholderImage = wh_imageNamed(@"home_banner_place");
        self.tableView.tableHeaderView = banner;
        _banner = banner;
    }
    return _banner;
}

@end
