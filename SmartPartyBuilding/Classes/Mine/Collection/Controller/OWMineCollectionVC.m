//
//  OWMineCollectionVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/27.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "OWMineCollectionVC.h"
#import "OWNetworking.h"
#import "OWMineCollection.h"
#import "OWMineCollectionCell.h"

@interface OWMineCollectionVC ()

@property (nonatomic, strong) NSArray *collectionList;

@end

@implementation OWMineCollectionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的收藏";
    self.tableView.separatorStyle = NO;
    [self dataRequest];
}


- (void)dataRequest
{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/mark/myList") parameters:nil success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            wh_Log(@"---%@",responseObject);
            self.collectionList = [OWMineCollection mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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
    return self.collectionList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWMineCollectionCell *cell = [OWMineCollectionCell cellWithTableView:tableView];
    cell.collection = self.collectionList[indexPath.row];
    return cell;
}


#pragma mark - ---------- TableViewDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWMineCollection *collection = self.collectionList[indexPath.row];
//    OWNoticeDetailVC *detailVC = [[OWNoticeDetailVC alloc] init];
//    detailVC.message = message;
//    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
