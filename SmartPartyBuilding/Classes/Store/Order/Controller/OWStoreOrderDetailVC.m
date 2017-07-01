//
//  OWStoreOrderDetailVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/21.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <SVProgressHUD.h>
#import "OWStoreOrderDetailVC.h"
#import "OWOrderDetailInfoCell.h"
#import "OWOrderDetailPriceCell.h"
#import "OWSubmitCell.h"
#import "OWStoreItem.h"
#import "OWNetworking.h"
#import "OWTool.h"

@interface OWStoreOrderDetailVC ()

@property (nonatomic, strong) NSArray *priceList;

@end

@implementation OWStoreOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"订单详情";
    
    [self setupTableView];
}

/** 设置tableview */
- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = NO;
    NSString *scoreStr = [NSString stringWithFormat:@"%d积分",self.item.integral ?: 0];
    self.priceList = @[
                       @{@"title":@"运费", @"content":@"包邮"},
                       @{@"title":@"商品价格", @"content":scoreStr},
                       @{@"title":@"订单总额", @"content":scoreStr}
                       ];
}

- (void)submitOrder
{
    [SVProgressHUD showWithStatus:@"正在提交..."];
    NSDictionary *userInfo = [OWTool getUserInfo];
    NSDictionary *par = @{
                          @"itemId":@(self.item.id),
                          @"num":@(1),
                          @"name":userInfo[@"staffName"],
                          @"phone":userInfo[@"phoneNumber"],
                          @"address":userInfo[@"address"]
                          };
    [OWNetworking HPOST:wh_appendingStr(wh_host, @"mobile/item/buy") parameters:par success:^(id  _Nullable responseObject) {
        wh_Log(@"---%@",responseObject);
        if ([responseObject[@"code"] intValue] == 200) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
        //            wh_Log(@"---%@",error);
    }];
}

#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 75.0f;
    }else if (indexPath.row == 4){
        return 150.0f;
    }else{
        return 45.0f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        OWOrderDetailInfoCell *cell = [OWOrderDetailInfoCell cellWithTableView:tableView];
        return cell;
    }else if (indexPath.row > 3){
        OWSubmitCell *cell = [OWSubmitCell cellWithTableView:tableView];
        cell.title = @"提交";
        wh_weakSelf(self);
        cell.block = ^(){
            [weakself submitOrder];
        };
        return cell;
    }else{
        OWOrderDetailPriceCell *cell = [OWOrderDetailPriceCell cellWithTableView:tableView];
        cell.priceDic = self.priceList[indexPath.row - 1];
        return cell;
    }
}
@end
