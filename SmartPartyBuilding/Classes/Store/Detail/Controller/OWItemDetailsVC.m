//
//  OWItemDetailsVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/21.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWItemDetailsVC.h"
#import "OWItemHeaderCell.h"
#import "OWItemDetailCell.h"
#import "OWStoreOrderDetailVC.h"

@interface OWItemDetailsVC ()

@end

@implementation OWItemDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"商品详情";
    
    [self setupTableView];
}

/** 设置tableview */
- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = NO;
}

#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return section ? 35.0f : CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 220;
    }else{
        return wh_screenHeight - 220;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section != 1) return nil;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, wh_screenWidth, 35)];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"商品详情";
    titleLabel.textColor = wh_norFontColor;
    titleLabel.font = [UIFont systemFontOfSize:14.5f];
    [headerView addSubview:titleLabel];
    [titleLabel makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(headerView);
    }];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = wh_lineColor;
    [headerView addSubview:lineView1];
    [lineView1 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.left.equalTo(headerView).offset(15);
        make.right.equalTo(titleLabel.left).offset(-15);
        make.height.equalTo(0.5);
    }];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = wh_lineColor;
    [headerView addSubview:lineView2];
    [lineView2 makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(headerView);
        make.right.equalTo(headerView).offset(-15);
        make.left.equalTo(titleLabel.right).offset(15);
        make.height.equalTo(0.5);
    }];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        OWItemHeaderCell *cell = [OWItemHeaderCell cellWithTableView:tableView];
        cell.item = self.item;
        wh_weakSelf(self);
        cell.block = ^(){
            OWStoreOrderDetailVC *detailVC = [[OWStoreOrderDetailVC alloc] init];
            detailVC.item = weakself.item;
            [weakself.navigationController pushViewController:detailVC animated:YES];
        };
        return cell;
    }else{
        OWItemDetailCell *cell = [OWItemDetailCell cellWithTableView:tableView];
        cell.item = self.item;
        return cell;
    }
}

@end
