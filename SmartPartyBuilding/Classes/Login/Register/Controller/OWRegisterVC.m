//
//  OWRegisterVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/24.
//  Copyright © 2017年 王卫华. All rights reserved.
//

//#import <Masonry.h>
//#import <ReactiveCocoa.h>
#import <MJExtension.h>
#import "OWRegisterVC.h"
#import "OWRegisterInputCell.h"
#import "OWRegisterPickerCell.h"
#import "OWRegister.h"

@interface OWRegisterVC ()

@property (nonatomic, strong) NSArray *registerList;

@end

@implementation OWRegisterVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"注册";
    
    wh_weakSelf(self);
    [self.tableView wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself.view endEditing:YES];
    }];
    
    [self setupNavi];
    [self setupTableView];
}

- (void)setupNavi
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem wh_itemWithType:WHItemTypeRight norTitle:@"提交" font:15.0f norColor:wh_RGB(9, 131, 216) highColor:[UIColor blueColor] offset:0 actionHandler:^(UIButton *sender) {
        wh_Log(@"---点击了注册");
    }];
}

- (void)setupTableView
{
    self.tableView.separatorStyle = NO;
    self.tableView.scrollEnabled = NO;
    NSArray *list = @[
                      @{@"image":@"login_act", @"place":@"请输入手机号"},
                      @{@"image":@"login_ver", @"place":@"请输入验证码"},
                      @{@"image":@"login_pwd", @"place":@"请输入密码"},
                      @{@"image":@"", @"place":@"再次输入密码"},
                      @{@"image":@"login_name", @"place":@"请输入姓名/昵称"},
                      @{@"image":@"login_id", @"place":@"请输入身份证号(选填)"},
                      @{@"sex":@"", @"duty":@"", @"organize":@""}
                      ];
    self.registerList = [OWRegister mj_objectArrayWithKeyValuesArray:list];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.registerList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row < 6) ? 50.0f : 120.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 6) {
        OWRegisterInputCell *cell = [OWRegisterInputCell cellWithTableView:tableView];
        cell.regist = self.registerList[indexPath.row];
        return cell;
    }else{
        OWRegisterPickerCell *cell = [OWRegisterPickerCell cellWithTableView:tableView];
        return cell;
    }
    
}

#pragma mark - ---------- Lazy ----------



@end
