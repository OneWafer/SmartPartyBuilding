//
//  OWOfficeVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/19.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWOfficeVC.h"
#import "OWMineOptionCell.h"
#import "OWMettingManagerVC.h"
#import "OWCommodityVC.h"
#import "OWCarManagerVC.h"

@interface OWOfficeVC ()

@property (nonatomic, strong) NSArray *optionList;

@end

@implementation OWOfficeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"办公";
    
    [self setupTableView];
}

/** 设置tableview */
- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    //    self.tableView.backgroundColor = wh_RGB(244, 245, 246);
    self.tableView.showsVerticalScrollIndicator = NO;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 47.0f;
    
    self.optionList = @[
                        @{@"image" : @"office_forum", @"title" : @"内部论坛"},
                        @{@"image" : @"office_meeting", @"title" : @"会议管理"},
                        @{@"image" : @"office_commodity", @"title" : @"用品管理"},
                        @{@"image" : @"office_car", @"title" : @"车辆管理"}
                        ];
}

#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section ? 3 : 1;
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
    OWMineOptionCell *cell = [OWMineOptionCell cellWithTableView:tableView];
    cell.optionDic = self.optionList[indexPath.row + indexPath.section];
    return cell;
}


#pragma mark - ---------- TableViewDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    }else{
        if (indexPath.row == 0) {
            OWMettingManagerVC *mtVC = [[OWMettingManagerVC alloc] init];
            [self.navigationController pushViewController:mtVC animated:YES];
        }else if (indexPath.row == 1){
            OWCommodityVC *cdVC = [[OWCommodityVC alloc] init];
            [self.navigationController pushViewController:cdVC animated:YES];
//            OWStoreVC *storeVC = [[OWStoreVC alloc] init];
//            [self.navigationController pushViewController:storeVC animated:YES];
        }else{
            OWCarManagerVC *carVC = [[OWCarManagerVC alloc] init];
            [self.navigationController pushViewController:carVC animated:YES];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
