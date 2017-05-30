//
//  OWMineVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/14.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWMineVC.h"
#import "OWUserInfoVC.h"
#import "OWSettingVC.h"
#import "OWMineHeaderView.h"
#import "OWMineOptionCell.h"

@interface OWMineVC ()

@property (nonatomic, strong) OWMineHeaderView *headerView;
@property (nonatomic, strong) NSArray *optionList;
@property (nonatomic, weak) UIButton *logoutBtn;

@end

@implementation OWMineVC

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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self setupNavi];
    [self setupLogoutBtn];
    
    
}

/** 设置tableview */
- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.headerView = [[OWMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, wh_screenWidth, 120)];
    self.tableView.tableHeaderView = self.headerView;
    wh_weakSelf(self);
    self.headerView.headerBlock = ^(){
        OWUserInfoVC *userInfoVC = [[OWUserInfoVC alloc] init];
        [weakself.navigationController pushViewController:userInfoVC animated:YES];
    };
    
    self.optionList = @[
                        @{@"image" : @"mine_collection", @"title" : @"收藏"},
                        @{@"image" : @"mine_comment", @"title" : @"评论"},
                        @{@"image" : @"mine_release", @"title" : @"发布"},
                        @{@"image" : @"mine_pay", @"title" : @"党费缴纳"}
                        ];
}

/** 设置UIBarButtonItem */
- (void)setupNavi
{
    wh_weakSelf(self);
    UIBarButtonItem *setItem = [UIBarButtonItem wh_itemWithType:WHItemTypeRight norImage:@"navi_setting" highImage:@"navi_setting" offset:0.0f actionHandler:^(UIButton *sender) {
        OWSettingVC *settingVC = [[OWSettingVC alloc] init];
        [weakself.navigationController pushViewController:settingVC animated:YES];
    }];
    
    UIBarButtonItem *messageItem = [UIBarButtonItem wh_itemWithType:WHItemTypeRight norImage:@"navi_message" highImage:@"navi_message" offset:0.0f actionHandler:^(UIButton *sender) {
        wh_Log(@"点击了消息按钮");
    }];
    
    self.navigationItem.rightBarButtonItems = @[messageItem, setItem];
}

/** 设置退出登录按钮 */
- (void)setupLogoutBtn
{
    [self.logoutBtn wh_addActionHandler:^(UIButton *sender) {
        wh_Log(@"点击了退出登录");
    }];
}


#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section? 1 : 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OWMineOptionCell *cell = [OWMineOptionCell cellWithTableView:tableView];
    cell.optionDic = self.optionList[indexPath.row + indexPath.section * 3];
    return cell;
    
}


#pragma mark - ---------- Lazy ----------

- (UIButton *)logoutBtn
{
    if (!_logoutBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"退出登录" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setBackgroundColor:wh_RGB(214, 17, 23)];
        [self.tableView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.tableView).offset(350);
            make.width.equalTo(self.view).multipliedBy(0.8);
            make.height.equalTo(40);
        }];
        btn.layer.cornerRadius = 3;
        _logoutBtn = btn;
    }
    return _logoutBtn;
}

@end
