//
//  OWHomeActivityVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/27.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "OWHomeActivityVC.h"
#import "OWHomeActivity.h"
#import "OWHomeActivityCell.h"
#import "OWNetworking.h"
#import "OWHomeActDetailVC.h"

@interface OWHomeActivityVC ()

@property (nonatomic, strong) NSArray *activityList;

@end

@implementation OWHomeActivityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"组织活动";
    self.tableView.separatorStyle = NO;
    [self dataRequest];
}



- (void)dataRequest
{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/activity/activityList") parameters:nil success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            wh_Log(@"---%@",responseObject);
            self.activityList = [OWHomeActivity mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
    }];
}


#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.activityList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWHomeActivityCell *cell = [OWHomeActivityCell cellWithTableView:tableView];
    cell.act = self.activityList[indexPath.row];
    return cell;
}


#pragma mark - ---------- TableViewDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWHomeActivity *activity = self.activityList[indexPath.row];
    OWHomeActDetailVC *detailVC = [[OWHomeActDetailVC alloc] init];
    detailVC.activity = activity;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
