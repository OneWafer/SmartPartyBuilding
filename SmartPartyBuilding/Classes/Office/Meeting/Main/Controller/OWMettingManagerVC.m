//
//  OWMettingManagerVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/20.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "OWMettingManagerVC.h"
#import "OWMettingManagerCell.h"
#import "OWMettingDetailVC.h"
#import "OWNetworking.h"
#import "OWRefreshGifHeader.h"
#import "OWMeeting.h"
@interface OWMettingManagerVC ()

@property (nonatomic, strong) NSMutableArray *meetList;

@end

@implementation OWMettingManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"会议室管理";
    
    [self setupTableView];
    [self setupRefresh];
}

/** 设置tableview */
- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.rowHeight = 100.0f;
    self.meetList = [NSMutableArray array];
}

- (void)setupRefresh
{
    wh_weakSelf(self);
    self.tableView.mj_header = [OWRefreshGifHeader headerWithRefreshingBlock:^{
        [weakself dataRequest];
    }];
    [self.tableView.mj_header beginRefreshing];
}

- (void)dataRequest
{
    NSDictionary *par = @{
                          @"page":@"1",
                          @"rows":@"20"
                          };
    [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/meetingRoom/list") parameters:par success:^(id  _Nullable responseObject) {
        wh_Log(@"---%@",responseObject);
        if ([responseObject[@"code"] intValue] == 200) {
            self.meetList = [OWMeeting mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            wh_Log(@"%@",self.meetList);
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
        }
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
        [self.tableView.mj_header endRefreshing];
    }];
}


#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.meetList.count;
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
    cell.meet = self.meetList[indexPath.section];
    return cell;
}


#pragma mark - ---------- TableViewDataDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWMettingDetailVC *detailVC = [[OWMettingDetailVC alloc] init];
    detailVC.meet = self.meetList[indexPath.section];
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
