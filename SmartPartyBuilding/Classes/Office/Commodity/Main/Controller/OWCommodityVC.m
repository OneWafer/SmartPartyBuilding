//
//  OWCommodityVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/23.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWCommodityVC.h"
#import "OWCommodityCartCell.h"
#import "OWHomeTitleCell.h"
#import "OWCommodityFallCell.h"

@interface OWCommodityVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic ,weak) UITableView *tableView;
@property (nonatomic, weak) UIView *bottomView;
@property (nonatomic, weak) UIButton *deleteBtn;
@property (nonatomic, weak) UIButton *confirmBtn;
@property (nonatomic, weak) UIButton *allSltBtn;

@end

@implementation OWCommodityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"用品管理";
    
    [self setupBottomView];
}


- (void)setupBottomView
{
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    [self.confirmBtn wh_addActionHandler:^(UIButton *sender) {
        wh_Log(@"---点击了确认");
    }];
    
    [self.deleteBtn wh_addActionHandler:^(UIButton *sender) {
        wh_Log(@"---点击了删除");
    }];
    
    [self.allSltBtn wh_addActionHandler:^(UIButton *sender) {
        sender.selected = !sender.selected;
        wh_Log(@"点击了全选");
    }];
}

#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section ? 1 : 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 100.0f;
    }else if (indexPath.section == 1){
        return 45.0f;
    }else{
        return ((wh_screenWidth - 30) * 0.75 + 10) * 5 + 10;
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        OWCommodityCartCell *cell = [OWCommodityCartCell cellWithTableView:tableView];
        return cell;
    }else if (indexPath.section == 1){
        OWHomeTitleCell *cell = [OWHomeTitleCell cellWithTableView:tableView];
        return cell;
    }else{
        OWCommodityFallCell *cell = [OWCommodityFallCell cellWithTableView:tableView];
        cell.block = ^(){
            wh_Log(@"点击了添加");
        };
        return cell;
    }
}


#pragma mark - ---------- Lazy ----------

- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.scrollIndicatorInsets = tableView.contentInset;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (UIView *)bottomView
{
    if (!_bottomView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.height.equalTo(49);
        }];
        _bottomView = view;
    }
    return _bottomView;
}


- (UIButton *)confirmBtn
{
    if (!_confirmBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"确认" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:wh_RGB(228, 3, 2)];
        [self.bottomView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self.bottomView);
            make.width.equalTo(90);
        }];
        _confirmBtn = btn;
    }
    return _confirmBtn;
}


- (UIButton *)deleteBtn
{
    if (!_deleteBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"删除" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:wh_RGB(239, 175, 6)];
        [self.bottomView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.equalTo(self.confirmBtn);
            make.right.equalTo(self.confirmBtn.left);
        }];
        _deleteBtn = btn;
    }
    return _deleteBtn;
}


- (UIButton *)allSltBtn
{
    if (!_allSltBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"全选" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [btn setTitleColor:wh_norFontColor forState:UIControlStateNormal];
        [btn setImage:wh_imageNamed(@"office_cmd_radio") forState:UIControlStateNormal];
        [btn setImage:wh_imageNamed(@"office_cmd_radio_slt") forState:UIControlStateSelected];
        [btn wh_setImagePosition:WHImagePositionLeft spacing:5];
        [self.bottomView addSubview:btn];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.bottomView);
            make.left.equalTo(15);
        }];
        _allSltBtn = btn;
    }
    return _allSltBtn;
}
@end
