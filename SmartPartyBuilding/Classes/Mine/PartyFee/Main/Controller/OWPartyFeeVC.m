//
//  OWPartyFeeVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/10.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWPartyFeeVC.h"
#import "OWPartyFeeDescCell.h"
#import "OWPartyFeeConfCell.h"
#import "OWSubmitCell.h"
#import "OWPicker.h"

@interface OWPartyFeeVC ()

@property (nonatomic, assign) NSInteger month;

@end

@implementation OWPartyFeeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"党费缴纳";
    
    [self setupTableView];
}

/** 设置tableview */
- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = NO;
}


- (void)dataSubmit
{
    
}


#pragma mark - ---------- TableViewDataSource ----------


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
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
        return 250.0f;
    }else if (indexPath.row == 1){
        return 70.0f;
    }else{
        return 150.0f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    wh_weakSelf(self);
    if (indexPath.row == 0) {
        OWPartyFeeDescCell *cell = [OWPartyFeeDescCell cellWithTableView:tableView];
        __weak OWPartyFeeDescCell *weakCell = cell;
        cell.block = ^(){
            NSArray *typeList = @[@"1个月", @"2个月", @"3个月", @"4个月", @"5个月", @"6个月",];
            [[OWPicker pickLinearData:typeList forView:self.view.window selectedBlock:^BOOL(BOOL isCancel, NSArray<NSString *> *selectedTitles, NSArray<NSNumber *> *indexs) {
                if (isCancel) return YES;
                [weakCell.sltBtn setTitle:selectedTitles[0] forState:UIControlStateNormal];
                [weakCell.sltBtn wh_setImagePosition:WHImagePositionRight spacing:5];
                self.month = [[indexs firstObject] integerValue] + 1;
                [self.tableView reloadData];
                return YES;
            }] show:YES];
        };
        return cell;
    }else if (indexPath.row == 1) {
        OWPartyFeeConfCell *cell = [OWPartyFeeConfCell cellWithTableView:tableView];
        cell.month = self.month;
        return cell;
    }else{
        OWSubmitCell *cell = [OWSubmitCell cellWithTableView:tableView];
        cell.title = @"提交申请";
        cell.block = ^(){
            [weakself dataSubmit];
        };
        return cell;
    }
}


#pragma mark - ---------- Lazy ----------


@end
