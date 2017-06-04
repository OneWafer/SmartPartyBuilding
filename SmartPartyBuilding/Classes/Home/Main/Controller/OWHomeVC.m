//
//  OWHomeVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/14.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <MJRefresh.h>
#import <MJExtension.h>
#import <LBXScanView.h>
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
#import "OWScanVC.h"

@interface OWHomeVC ()<SDCycleScrollViewDelegate>

@property (nonatomic, weak) SDCycleScrollView *banner;
@property (nonatomic, strong) NSArray *funcTitleList;
@property (nonatomic, strong) NSArray *sectionTitleList;

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
    
    [self setupTableView];
    [self setupNavi];
    [self setupBanner];
    
}


/** 设置tableview */
- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    
    self.funcTitleList = @[
                           @{@"image":@"home_func_message",@"title":@"通知公告"},
                           @{@"image":@"home_func_study",@"title":@"党员学习"},
                           @{@"image":@"home_func_activity",@"title":@"组织活动"},
                           @{@"image":@"home_func_member",@"title":@"优秀党员"},
                           @{@"image":@"home_func_consult",@"title":@"互动咨询"},
                           @{@"image":@"home_func_approve",@"title":@"公文审批"},
                           @{@"image":@"home_func_election",@"title":@"投票选举"},
                           @{@"image":@"home_func_office",@"title":@"办公"}
                           ];

    self.sectionTitleList = @[
                              @{@"image":@"home_title_news",@"title":@"党建要闻"}
                              ];
}

- (void)setupNavi
{
    wh_weakSelf(self);
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem wh_itemWithType:WHItemTypeLeft norImage:@"navi_home_scan" highImage:@"navi_home_scan" offset:0 actionHandler:^(UIButton *sender) {
        
        OWScanVC *scanVC = [[OWScanVC alloc] init];
        scanVC.style = [weakself scanStyle];
        scanVC.isOpenInterestRect = YES;
        [weakself.navigationController pushViewController:scanVC animated:YES];
    }];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem wh_itemWithType:WHItemTypeRight norImage:@"navi_home_message" highImage:@"navi_home_message" offset:0 actionHandler:^(UIButton *sender) {
        wh_Log(@"---点击了消息");
    }];
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
    NSArray *imagesURLStrings = @[
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496489725660&di=ce1be01e531b3591244230cd1c5f8641&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F13%2F85%2F93%2F18f58PIC4tg_1024.jpg",
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496489725660&di=ce1be01e531b3591244230cd1c5f8641&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F13%2F85%2F93%2F18f58PIC4tg_1024.jpg",
                                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496489725660&di=ce1be01e531b3591244230cd1c5f8641&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F13%2F85%2F93%2F18f58PIC4tg_1024.jpg"
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
    return (section >= 3) ? 5 : 1;
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
        cell.titleList = self.funcTitleList;
        wh_weakSelf(self);
        cell.funcBtnBlock = ^(NSInteger tag){
            [weakself funcBtnClick:tag];
        };
        return cell;
    }else if (indexPath.section == 1){
        OWHomeHeadlineCell *cell = [OWHomeHeadlineCell cellWithTableView:tableView];
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
    }else if (tag == 1006){
        OWHomeApprovalVC *approval = [[OWHomeApprovalVC alloc] init];
        [weakself.navigationController pushViewController:approval animated:YES];
    }else if (tag == 1008){
        weakself.tabBarController.selectedIndex = 1;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint translation = scrollView.contentOffset;
    CGFloat alpha = translation.y * 0.005;
    [self.navigationController.navigationBar setValue:@(alpha) forKeyPath:@"backgroundView.alpha"];
    wh_Log(@"---%f",translation.y);
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
        SDCycleScrollView *banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, wh_screenWidth, 160) delegate:self placeholderImage:wh_imageNamed(@"")];
        banner.currentPageDotColor = [UIColor redColor];
        banner.autoScrollTimeInterval = 3.0f;
        self.tableView.tableHeaderView = banner;
        _banner = banner;
    }
    return _banner;
}

@end
