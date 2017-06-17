//
//  OWDisOldPartyVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/15.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "OWDisOldPartyVC.h"
#import "OWDisInputCell.h"
#import "OWDisInputViewCell.h"
#import "OWDisInput.h"
#import "OWNetworking.h"
#import "OWPicker.h"
#import "OWTool.h"

@interface OWDisOldPartyVC ()

@property (nonatomic, strong) NSArray *inputList;
@property (nonatomic, weak) UIButton *submitBtn;

@end

@implementation OWDisOldPartyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"老党员申请";
    
    [self setupTableView];
    [self setupSubmitBtn];
}

/** 设置tableview */
- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = NO;
    
    NSDictionary *userInfo = [OWTool getUserInfo];
    NSArray *arr = @[
                     @{@"place":@"党员姓名", @"content":userInfo[@"staffName"] ?: @""},
                     @{@"place":@"出生年月", @"content":@""},
                     @{@"place":@"入党日期", @"content":@""},
                     @{@"place":@"优秀事迹", @"content":@""},
                     @{@"place":@"其他说明", @"content":@""}
                     ];
    
    self.inputList = [OWDisInput mj_objectArrayWithKeyValuesArray:arr];
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
    [SVProgressHUD showWithStatus:@"正在提交..."];
    UITextField *tf1 = [self.view viewWithTag:1001];
    UITextField *tf2 = [self.view viewWithTag:1002];
    UITextField *tf3 = [self.view viewWithTag:1003];
    UITextField *tf4 = [self.view viewWithTag:1004];
    UITextField *tv = [self.view viewWithTag:1005];
    
    NSDictionary *par = @{
                          @"":tf1.text,
                          @"":tf2.text,
                          @"":tf3.text,
                          @"":tf4.text,
                          @"":tv.text
                          };
    
//        wh_Log(@"---%@-%@-%@-%@-%@-%@-%@",tf1.text,tf2.text,tf3.text,tv.text);
    
    [OWNetworking HPOST:wh_appendingStr(wh_host, @"") parameters:par success:^(id  _Nullable responseObject) {
        wh_Log(@"---%@",responseObject);
        if ([responseObject[@"code"] intValue] == 200) {
            
            [SVProgressHUD showSuccessWithStatus:@"提交成功!"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
        wh_Log(@"---%@",error);
    }];
}


#pragma mark - ---------- TableViewDataSource ----------


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.inputList.count;
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
    return (indexPath.row < 4) ? 45.0f : 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 4) {
        OWDisInputCell *cell = [OWDisInputCell cellWithTableView:tableView];
        cell.inputTF.tag = 1001 + indexPath.row;
        cell.input = self.inputList[indexPath.row];
        return cell;
    }else{
        OWDisInputViewCell *cell = [OWDisInputViewCell cellWithTableView:tableView];
        cell.inputView.tag = 1001 + indexPath.row;
        cell.input = self.inputList[indexPath.row];
        return cell;
    }
}


#pragma mark - ---------- TableViewDataDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1 || indexPath.row == 2) {
        OWPicker *picker = [OWPicker pickDateForView:self.view.window initialDate:[NSDate date] selectedBlock:^BOOL(BOOL isCancel, NSDate *date) {
            if (isCancel) return YES;
            OWDisInputCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.inputTF.text = [date wh_getDateStringWithFormat:@"yyyy-MM-dd"];
            cell.input.content = [date wh_getDateStringWithFormat:@"yyyy-MM-dd"];
            return YES;
        }];
        [picker show:YES];
    }
}


#pragma mark - ---------- Lazy ----------

- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"提交申请" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [btn setBackgroundColor:wh_themeColor];
        [self.tableView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.tableView).offset(330);
            make.width.equalTo(self.view).multipliedBy(0.8);
            make.height.equalTo(45);
        }];
        btn.layer.cornerRadius = 4;
        _submitBtn = btn;
    }
    return _submitBtn;
}

@end
