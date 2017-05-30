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
#import "OWHomeTitleCell.h"
#import "OWHomeActivityCell.h"
#import "OWModuleCell.h"
#import "OWHomeNoticeVC.h"
#import "OWHomeApprovalVC.h"
#import "OWScanVC.h"

@interface OWHomeVC ()<SDCycleScrollViewDelegate>

@property (nonatomic, weak) SDCycleScrollView *banner;
@property (nonatomic, strong) NSArray *funcTitleList;

@end

@implementation OWHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"智慧开发区";
    
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
    
    self.funcTitleList = @[@"通知公告", @"党员学习", @"组织活动",@"优秀党员", @"互动咨询", @"公文审批",@"投票选举", @"办公"];
}

- (void)setupNavi
{
    wh_weakSelf(self);
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem wh_itemWithType:WHItemTypeLeft norImage:@"navi_scan" highImage:@"navi_scan" offset:0 actionHandler:^(UIButton *sender) {
        
        OWScanVC *scanVC = [[OWScanVC alloc] init];
        scanVC.style = [weakself scanStyle];
        scanVC.isOpenInterestRect = YES;
        [weakself.navigationController pushViewController:scanVC animated:YES];
    }];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem wh_itemWithType:WHItemTypeRight norImage:@"" highImage:@"" offset:0 actionHandler:^(UIButton *sender) {
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
        return 1;
    }else if (section == 2){
        return 2;
    }else if (section == 3){
        return 3;
    }else{
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 140.0f;
    }else if (indexPath.section == 2 && indexPath.row == 1){
        return wh_screenWidth * 0.7;
    }else{
        return indexPath.row ? 50.0f : 30.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *imgList = @[
                         @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1494784669472&di=3f59d89526e0ceefb6187a4e32410e2d&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F47%2F45%2F55558PICaI3_1024.png",
                         @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1494784710339&di=e160b4dcd8f10554b1e46d79047fcddd&imgtype=0&src=http%3A%2F%2Fpic.35pic.com%2Fnormal%2F00%2F00%2F00%2F4516838_104731063286_2.jpg",
                         @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=487686473,794182214&fm=23&gp=0.jpg",
                         @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1494784734310&di=44ce408bba78eb7bdf4b0e928afa0515&imgtype=0&src=http%3A%2F%2Fpic.58pic.com%2F58pic%2F15%2F51%2F31%2F02p58PICGNc_1024.png"];
    NSDictionary *dic = @{
                          @"title":self.funcTitleList,
                          @"image":imgList
                          };
    if (indexPath.section == 0) {
        OWFuncBtnsCell *cell = [OWFuncBtnsCell cellWithTableView:tableView];
        cell.titleDic = dic;
        wh_weakSelf(self);
        cell.funcBtnBlock = ^(NSInteger tag){
            [weakself funcBtnClick:tag];
        };
        return cell;
    }else if (indexPath.section == 2 && indexPath.row == 1){
        OWModuleCell *cell = [OWModuleCell cellWithTableView:tableView];
        return cell;
    }else{
        if (indexPath.row == 0) {
            OWHomeTitleCell *cell = [OWHomeTitleCell cellWithTableView:tableView];
            return cell;
        }else{
            OWHomeActivityCell *cell = [OWHomeActivityCell cellWithTableView:tableView];
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
