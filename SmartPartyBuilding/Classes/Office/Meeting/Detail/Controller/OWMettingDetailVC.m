//
//  OWMettingDetailVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/20.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <MJRefresh.h>
#import <MJExtension.h>
#import <SDCycleScrollView.h>
#import "OWMettingDetailVC.h"
#import "OWMeetingDetailCell.h"
#import "OWHomeTitleCell.h"
#import "OWMeetingDateCell.h"
#import "OWMeetingOrderCell.h"
#import "OWMettingOrderVC.h"

@interface OWMettingDetailVC ()<SDCycleScrollViewDelegate>

@property (nonatomic, weak) SDCycleScrollView *banner;

@end

@implementation OWMettingDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"详情";
    
    [self setupTableView];
    [self setupNavi];
    [self setupBanner];
}



/** 设置tableview */
- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    //    self.tableView.backgroundColor = wh_RGB(244, 245, 246);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)setupNavi
{
    wh_weakSelf(self);
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem wh_itemWithType:WHItemTypeRight norTitle:@"预约" font:14 norColor:wh_RGB(9, 131, 216) highColor:[UIColor blueColor] offset:0 actionHandler:^(UIButton *sender) {
        OWMettingOrderVC *orderVC = [[OWMettingOrderVC alloc] init];
        [weakself.navigationController pushViewController:orderVC animated:YES];
    }];
}

/** 设置轮播图 */
- (void)setupBanner
{
    NSArray *imagesURLStrings = @[
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1494773023703&di=dedf33f0672ac0d49a242695e22d5fcd&imgtype=0&src=http%3A%2F%2Fimg05.tooopen.com%2Fimages%2F20141121%2Fsy_75486386736.jpg",
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1494772943184&di=0bcdd782ea3c423d854b3917800a794f&imgtype=0&src=http%3A%2F%2Fi0.hdslb.com%2Fbfs%2Farchive%2F15e28feda126018d913a0d46ea44b2c315c3f8b3.jpg",
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1494772966253&di=644adb45cd9618006be8ce42a8ff804e&imgtype=0&src=http%3A%2F%2Fwww.neeu.com%2Fuploads%2Fimages%2F2016%2F10%2F14%2F1476430713738.jpg"
                                  ];
    self.banner.imageURLStringsGroup = imagesURLStrings;
}

#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }else if (section == 1){
        return 1;
    }else if (section == 2){
        return 1+1;
    }else{
        return 2+1;
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
        return cell;
    }else if (indexPath.section == 1){
        OWHomeTitleCell *cell = [OWHomeTitleCell cellWithTableView:tableView];
        return cell;
    }else{
        if (indexPath.row == 0){
            OWMeetingDateCell *cell = [OWMeetingDateCell cellWithTableView:tableView];
            cell.title = @"今天";
            return cell;
        }else{
            OWMeetingOrderCell *cell = [OWMeetingOrderCell cellWithTableView:tableView];
            return cell;
        }
        
    }
}



#pragma mark - ---------- Lazy ----------
- (SDCycleScrollView *)banner
{
    if (!_banner) {
        SDCycleScrollView *banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, wh_screenWidth, 160) delegate:self placeholderImage:wh_imageNamed(@"")];
        banner.currentPageDotColor = [UIColor redColor];
        banner.autoScrollTimeInterval = 3.0f;
        self.tableView.tableHeaderView = banner;
        _banner = banner;
    }
    return _banner;
}

@end
