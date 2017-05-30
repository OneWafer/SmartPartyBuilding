//
//  OWMettingManagerVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/20.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWMettingManagerVC.h"
#import "OWMettingManagerCell.h"
#import "OWMettingDetailVC.h"

@interface OWMettingManagerVC ()

@end

@implementation OWMettingManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"会议室管理";
    
    [self setupTableView];
}

/** 设置tableview */
- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    //    self.tableView.backgroundColor = wh_RGB(244, 245, 246);
    self.tableView.showsVerticalScrollIndicator = NO;
    //    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 100.0f;
}


#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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
    OWMettingManagerCell *cell = [OWMettingManagerCell cellWithTableView:tableView];
    return cell;
}


#pragma mark - ---------- TableViewDataDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWMettingDetailVC *detailVC = [[OWMettingDetailVC alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
