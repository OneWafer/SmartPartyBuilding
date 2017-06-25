//
//  OWVolunteerVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/25.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "OWVolunteerVC.h"
#import "OWVolunActCell.h"
#import "OWVolunAct.h"
#import "OWNetworking.h"

@interface OWVolunteerVC ()

@property (nonatomic, strong) NSArray *volunActList;

@end

@implementation OWVolunteerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"志愿者大厅";
    self.tableView.separatorStyle = NO;
    [self dataRequest];
}


- (void)dataRequest
{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/activity/volunteerList") parameters:nil success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            wh_Log(@"---%@",responseObject);
            self.volunActList = [OWVolunAct mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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
    return self.volunActList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWVolunActCell *cell = [OWVolunActCell cellWithTableView:tableView];
    cell.act = self.volunActList[indexPath.row];
    return cell;
}


#pragma mark - ---------- TableViewDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWVolunAct *act = self.volunActList[indexPath.row];
//    OWNoticeDetailVC *detailVC = [[OWNoticeDetailVC alloc] init];
//    detailVC.act = act;
//    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
