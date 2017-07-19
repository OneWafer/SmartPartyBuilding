//
//  OWThumbupVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/27.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "OWThumbupVC.h"
#import "OWNetworking.h"
#import "OWMineThumbup.h"
#import "OWMineThumbupCell.h"
#import "OWThumbupDetailVC.h"

@interface OWThumbupVC ()

@property (nonatomic, strong) NSArray *thumbupList;

@end

@implementation OWThumbupVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的点赞";
    self.tableView.separatorStyle = NO;
    [self dataRequest];
}

- (void)dataRequest
{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/like/myList") parameters:nil success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            wh_Log(@"---%@",responseObject);
            self.thumbupList = [OWMineThumbup mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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
    return self.thumbupList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWMineThumbupCell *cell = [OWMineThumbupCell cellWithTableView:tableView];
    cell.thumbup = self.thumbupList[indexPath.row];
    return cell;
}


#pragma mark - ---------- TableViewDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWMineThumbup *thumbup = self.thumbupList[indexPath.row];
        OWThumbupDetailVC *detailVC = [[OWThumbupDetailVC alloc] init];
        detailVC.thumbup = thumbup;
        [self.navigationController pushViewController:detailVC animated:YES];
}

@end
