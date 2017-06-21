//
//  OWStoreOrderDetailVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/21.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWStoreOrderDetailVC.h"
#import "OWOrderDetailInfoCell.h"
#import "OWOrderDetailPriceCell.h"
#import "OWSubmitCell.h"

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
    
    self.priceList = @[
                       @{@"title":@"运费", @"content":@"包邮"},
                       @{@"title":@"商品价格", @"content":@"999积分"},
                       @{@"title":@"订单总额", @"content":@"999积分"}
                       ];
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
        cell.block = ^(){
            wh_Log(@"---点击了提交");
        };
        return cell;
    }else{
        OWOrderDetailPriceCell *cell = [OWOrderDetailPriceCell cellWithTableView:tableView];
        cell.priceDic = self.priceList[indexPath.row - 1];
        return cell;
    }
}
@end
