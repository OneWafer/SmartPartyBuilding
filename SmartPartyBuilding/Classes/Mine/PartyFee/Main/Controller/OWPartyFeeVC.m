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

@interface OWPartyFeeVC ()

@property (nonatomic, weak) UIButton *submitBtn;

@end

@implementation OWPartyFeeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"党费缴纳";
    
    [self setupTableView];
    [self setupSubmitBtn];
    
}

/** 设置tableview */
- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = NO;
    CGFloat bottomEdge = 600.0f - wh_screenHeight;
    if (bottomEdge <= 0) bottomEdge = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, bottomEdge, 0);
}

- (void)setupSubmitBtn
{
    wh_weakSelf(self);
    [self.submitBtn wh_addActionHandler:^(UIButton *sender) {
        [weakself dataSubmit];
    }];
}

- (void)dataSubmit
{
    
}


#pragma mark - ---------- TableViewDataSource ----------


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
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
    return indexPath.row ? 70.0f : 250.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        OWPartyFeeDescCell *cell = [OWPartyFeeDescCell cellWithTableView:tableView];
        return cell;
    }else{
        OWPartyFeeConfCell *cell = [OWPartyFeeConfCell cellWithTableView:tableView];
        return cell;
    }
}


#pragma mark - ---------- Lazy ----------

- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"缴费" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.5f];
        [btn setBackgroundColor:wh_themeColor];
        [self.tableView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.tableView).offset(400);
            make.width.equalTo(self.view).multipliedBy(0.8);
            make.height.equalTo(45);
        }];
        btn.layer.cornerRadius = 4;
        _submitBtn = btn;
    }
    return _submitBtn;
}

@end
