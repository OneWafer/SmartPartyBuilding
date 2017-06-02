//
//  OWCarManagerVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/31.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <MJRefresh.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "OWCarManagerVC.h"
#import "OWMettingManagerCell.h"
#import "OWNetworking.h"
#import "OWCar.h"

@interface OWCarManagerVC ()

@property (nonatomic, strong) NSMutableArray *carList;
@end

@implementation OWCarManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"车辆管理";
    
    [self setupTableView];
    [self dataRequest];
}


/** 设置tableview */
- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.rowHeight = 100.0f;
    self.carList = [NSMutableArray array];
}

- (void)dataRequest
{
    NSDictionary *par = @{
                          @"page":@"1",
                          @"rows":@"20"
                          };
    [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/car/list") parameters:par success:^(id  _Nullable responseObject) {
        wh_Log(@"---%@",responseObject);
        if ([responseObject[@"code"] intValue] == 200) {
            self.carList = [OWCar mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            wh_Log(@"%@",self.carList);
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
        wh_Log(@"---%@",error);
    }];
}


#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.carList.count;
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
    cell.car = self.carList[indexPath.section];
    return cell;
}


#pragma mark - ---------- TableViewDataDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    OWMettingDetailVC *detailVC = [[OWMettingDetailVC alloc] init];
//    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
