//
//  OWHomeVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/14.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <MJExtension.h>
#import <LBXScanView.h>
#import <SVProgressHUD.h>
#import <ReactiveCocoa.h>
#import <SDCycleScrollView.h>
#import "OWHomeVC.h"
#import "OWNetworking.h"
#import "OWFuncBtnsCell.h"
#import "OWHomeHeadlineCell.h"
#import "OWHomeTitleCell.h"
#import "OWHomeNewsCell.h"
#import "OWModuleCell.h"
#import "OWHomeNoticeVC.h"
#import "OWHomeApprovalVC.h"
#import "OWExcPartyMemberVC.h"
#import "OWQuestionnaireVC.h"
#import "OWScanVC.h"
#import "OWBanner.h"
#import "OWNews.h"
#import "OWRefreshGifHeader.h"

@interface OWHomeVC ()<SDCycleScrollViewDelegate>

@property (nonatomic, weak) SDCycleScrollView *banner;
@property (nonatomic, strong) NSArray *funcImgList;
@property (nonatomic, strong) NSArray *sectionTitleList;
@property (nonatomic, strong) NSArray *bulletinList;
@property (nonatomic, strong) NSArray *newsList;
@property (nonatomic, strong) UIView *searchView;

@end

@implementation OWHomeVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置背景透明图片
    [self.navigationController.navigationBar setValue:@0 forKeyPath:@"backgroundView.alpha"];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setValue:@1 forKeyPath:@"backgroundView.alpha"];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    
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
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);

    self.sectionTitleList = @[
                              @{@"image":@"home_title_news",@"title":@"党建要闻"}
                              ];
}


- (void)setupNavi
{
    wh_weakSelf(self);
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem wh_itemWithType:WHItemTypeLeft norImage:@"navi_home_scan" highImage:@"navi_home_scan" offset:0 actionHandler:^(UIButton *sender) {
        
        [self.navigationController.navigationBar setValue:@1 forKeyPath:@"backgroundView.alpha"];
        OWScanVC *scanVC = [[OWScanVC alloc] init];
        scanVC.style = [weakself scanStyle];
        scanVC.isOpenInterestRect = YES;
        [weakself.navigationController pushViewController:scanVC animated:YES];
    }];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem wh_itemWithType:WHItemTypeRight norImage:@"navi_home_message" highImage:@"navi_home_message" offset:0 actionHandler:^(UIButton *sender) {
        wh_Log(@"---点击了消息");
    }];
    
    [self.searchView wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        wh_Log(@"---点击了搜索按钮");
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

/** 数据请求 */
- (void)dataRequest
{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    
    // 轮播图请求
    
    RACSignal *bannerRequest = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/appset/getShuffling") parameters:nil success:^(id  _Nullable responseObject) {
//            wh_Log(@"%@",responseObject);
            if ([responseObject[@"code"] intValue] == 200) {
                NSArray *bannerList = [OWBanner mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                
                [subscriber sendNext:bannerList];
                
            }else{
                [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
                [self.tableView.mj_header endRefreshing];
            }
        } failure:^(NSError * _Nonnull error) {
            [self.tableView.mj_header endRefreshing];
            [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
        }];
        
        return nil;
    }];
    
    
    // 按钮皮肤请求
    RACSignal *funcRequest = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/appset/getSkinVersion") parameters:nil success:^(id  _Nullable responseObject) {
//            wh_Log(@"%@",responseObject);
            if ([responseObject[@"code"] intValue] == 200) {
                NSMutableArray *funcImgList = [NSMutableArray array];
                for (int i = 0; i < 8; i ++) {
                    NSString *key = [NSString stringWithFormat:@"url%d",i+1];
                    [funcImgList addObject:[responseObject[@"data"] firstObject][key]];
                }
                self.funcImgList = [funcImgList mutableCopy];
                [subscriber sendNext:funcImgList];
                
            }else{
                [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
                [self.tableView.mj_header endRefreshing];
            }
        } failure:^(NSError * _Nonnull error) {
            [self.tableView.mj_header endRefreshing];
            [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
        }];
        return nil;
    }];
    
    // 党建快报请求
    RACSignal *bulletinRequest = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSDictionary *par = @{
                              @"page":@"1",
                              @"rows":@"20",
                              @"programaId":@"5"
                              };
        [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/news/getNews") parameters:par success:^(id  _Nullable responseObject) {
//            wh_Log(@"--%@",responseObject);
            if ([responseObject[@"code"] intValue] == 200) {
                self.bulletinList = [OWNews mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                [subscriber sendNext:self.bulletinList];
                
            }else{
                [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
                [self.tableView.mj_header endRefreshing];
            }
        } failure:^(NSError * _Nonnull error) {
            [self.tableView.mj_header endRefreshing];
            [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
        }];
        return nil;
    }];
    
    
    // 党建快报请求
    RACSignal *newsRequest = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSDictionary *par = @{
                              @"page":@"1",
                              @"rows":@"20",
                              @"programaId":@"6"
                              };
        [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/news/getNews") parameters:par success:^(id  _Nullable responseObject) {
            wh_Log(@"--%@",responseObject);
            if ([responseObject[@"code"] intValue] == 200) {
                self.newsList = [OWNews mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                [subscriber sendNext:self.newsList];
                
            }else{
                [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
                [self.tableView.mj_header endRefreshing];
            }
        } failure:^(NSError * _Nonnull error) {
            [self.tableView.mj_header endRefreshing];
            [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
        }];
        return nil;
    }];
    
    
    // 使用注意：几个信号，参数一的方法就几个参数，每个参数对应信号发出的数据。
    [self rac_liftSelector:@selector(updateUIWithR1:r2:r3:r4:) withSignalsFromArray:@[bannerRequest, funcRequest, bulletinRequest, newsRequest]];
}


// 更新UI
- (void)updateUIWithR1:(id)bannerList r2:(id)funcImgList r3:(id)bulletinList r4:(id)newsList
{
    [SVProgressHUD dismiss];
    [self.tableView.mj_header endRefreshing];
    // 取出banner图片数组
    NSMutableArray *banImgList = [NSMutableArray array];
    [bannerList wh_each:^(OWBanner *obj) {
        [banImgList addObject:obj.url];
    }];
    self.banner.imageURLStringsGroup = banImgList;
    [self.tableView reloadData];
    NSLog(@"更新UI-----:%@",bannerList);
}

- (LBXScanViewStyle *)scanStyle
{
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset = 60;
    style.xScanRetangleOffset = 30;
    
    if ([UIScreen mainScreen].bounds.size.height <= 480 )
    {
        //3.5inch 显示的扫码缩小
        style.centerUpOffset = 40;
        style.xScanRetangleOffset = 20;
    }
    
    style.notRecoginitonArea = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 2.0;
    style.photoframeAngleW = 16;
    style.photoframeAngleH = 16;
    
    style.isNeedShowRetangle = NO;
    style.anmiationStyle = LBXScanViewAnimationStyle_NetGrid;
    
    //使用的支付宝里面网格图片
    UIImage *imgFullNet = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_full_net"];
    style.animationImage = imgFullNet;
    
    return style;
}

/** 设置轮播图 */
- (void)setupBanner
{
    self.banner.imageURLStringsGroup = @[];
}


#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (section >= 3) ? self.newsList.count + 1 : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 160.0f;
    }else if (indexPath.section == 1){
        return 45;
    }else if (indexPath.section == 2){
        return 180.0f;
    }else{
        return indexPath.row ? 100.0f : 40.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (section == 0 || section == 3)? CGFLOAT_MIN : 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        OWFuncBtnsCell *cell = [OWFuncBtnsCell cellWithTableView:tableView];
        cell.imgList = self.funcImgList;
        wh_weakSelf(self);
        cell.funcBtnBlock = ^(NSInteger tag){
            [weakself funcBtnClick:tag];
        };
        return cell;
    }else if (indexPath.section == 1){
        OWHomeHeadlineCell *cell = [OWHomeHeadlineCell cellWithTableView:tableView];
        cell.newsList = self.bulletinList;
        return cell;
    }else if (indexPath.section == 2){
        OWModuleCell *cell = [OWModuleCell cellWithTableView:tableView];
        return cell;
    }else{
        if (indexPath.row == 0) {
            OWHomeTitleCell *cell = [OWHomeTitleCell cellWithTableView:tableView];
            cell.titleDic = self.sectionTitleList[0];
            return cell;
        }else{
            OWHomeNewsCell *cell = [OWHomeNewsCell cellWithTableView:tableView];
            cell.news = self.newsList[indexPath.row - 1];
            return cell;
        }
    }
    
}

/** 8个按钮的点击事件 */
- (void)funcBtnClick:(NSInteger)tag
{
    wh_weakSelf(self);
    if (tag == 1001) {
        OWHomeNoticeVC *noticeVC = [[OWHomeNoticeVC alloc] init];
        [weakself.navigationController pushViewController:noticeVC animated:YES];
    }else if (tag == 1004){
        OWExcPartyMemberVC *excPartyMember = [[OWExcPartyMemberVC alloc] init];
        [weakself.navigationController pushViewController:excPartyMember animated:YES];
    }else if (tag == 1006){
        OWHomeApprovalVC *approval = [[OWHomeApprovalVC alloc] init];
        [weakself.navigationController pushViewController:approval animated:YES];
    }else if (tag == 1007){
        OWQuestionnaireVC *questVC = [[OWQuestionnaireVC alloc] init];
        [weakself.navigationController pushViewController:questVC animated:YES];
    }else if (tag == 1008){
        
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint translation = scrollView.contentOffset;
    CGFloat alpha = translation.y * 0.005;
    [self.navigationController.navigationBar setValue:@(alpha) forKeyPath:@"backgroundView.alpha"];
    UIButton *scanBtn = (UIButton *)self.navigationItem.leftBarButtonItem.customView.subviews[0];
    UIButton *messageBtn = (UIButton *)self.navigationItem.rightBarButtonItem.customView.subviews[0];
    CGFloat color = translation.y * 0.455;
    if (color >= 55) color = 55;
    self.searchView.backgroundColor = wh_RGBA(255 - color, 255 - color, 255 - color, translation.y * 0.005 + 0.4);
    if (translation.y >= 100) {
        [scanBtn setImage:wh_imageNamed(@"navi_scan_black") forState:UIControlStateNormal];
        [messageBtn setImage:wh_imageNamed(@"navi_message_black") forState:UIControlStateNormal];
        self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
    }else{
        [scanBtn setImage:wh_imageNamed(@"navi_home_scan") forState:UIControlStateNormal];
        [messageBtn setImage:wh_imageNamed(@"navi_home_message") forState:UIControlStateNormal];
        self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    }
//    wh_Log(@"---%f",translation.y);
}

#pragma mark - ---------- SDCycleScrollViewDelegate ----------

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    wh_Log(@"---点击了第%ld张图片", (long)index);
}


#pragma mark - ---------- Lazy ----------
- (SDCycleScrollView *)banner
{
    if (!_banner) {
        SDCycleScrollView *banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, wh_screenWidth, 0.488*wh_screenWidth) delegate:self placeholderImage:wh_imageNamed(@"")];
        banner.currentPageDotColor = [UIColor redColor];
        banner.autoScrollTimeInterval = 3.0f;
        banner.placeholderImage = wh_imageNamed(@"home_banner_place");
        self.tableView.tableHeaderView = banner;
        _banner = banner;
    }
    return _banner;
}

- (UIView *)searchView
{
    if (!_searchView) {
        self.searchView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wh_screenWidth * 0.69, 28)];
        self.searchView.backgroundColor = wh_RGBA(255, 255, 255, 0.4);
        self.searchView.layer.cornerRadius = 14;
        
        UIImageView *searchImgView = [[UIImageView alloc] initWithImage:wh_imageNamed(@"navi_home_search")];
        [self.searchView addSubview:searchImgView];
        [searchImgView makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.searchView);
            make.left.equalTo(self.searchView).offset(10);
        }];
        
        UILabel *placeLabel = [[UILabel alloc] init];
        placeLabel.text = @"请输入搜索内容";
        placeLabel.textColor = [UIColor whiteColor];
        placeLabel.font = [UIFont systemFontOfSize:13.0f];
        [self.searchView addSubview:placeLabel];
        [placeLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(searchImgView);
            make.left.equalTo(searchImgView.right).offset(5);
        }];
        
        self.navigationItem.titleView = self.searchView;
    }
    return _searchView;
}

@end
