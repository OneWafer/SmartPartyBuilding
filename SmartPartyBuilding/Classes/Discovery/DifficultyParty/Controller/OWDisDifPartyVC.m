//
//  OWDisDifPartyVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/15.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "OWDisDifPartyVC.h"
#import "OWDisInputCell.h"
#import "OWDisInputViewCell.h"
#import "OWDisInput.h"
#import "OWNetworking.h"
#import "OWPicker.h"
#import "OWTool.h"

@interface OWDisDifPartyVC ()

@property (nonatomic, strong) NSArray *inputList;
@property (nonatomic, weak) UIButton *submitBtn;

@end

@implementation OWDisDifPartyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"困难党员申请";
    
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
    
    NSDictionary *userInfo = [OWTool getUserInfo];
    NSArray *arr = @[
                     @{@"place":@"党员姓名", @"content":userInfo[@"staffName"] ?: @""},
                     @{@"place":@"出生年月", @"content":@""},
                     @{@"place":@"入党日期", @"content":@""},
                     @{@"place":@"困难类型", @"content":@""},
                     @{@"place":@"享受低保", @"content":@""},
                     @{@"place":@"享受抚恤", @"content":@""},
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
    UITextField *tf5 = [self.view viewWithTag:1005];
    UITextField *tf6 = [self.view viewWithTag:1006];
    UITextField *tv = [self.view viewWithTag:1007];
    
    NSDictionary *par = @{
                          @"":tf1.text,
                          @"":tf2.text,
                          @"":tf3.text,
                          @"":tf4.text,
                          @"":tf5.text,
                          @"":tf6.text,
                          @"":tv.text
                          };
    
//    wh_Log(@"---%@-%@-%@-%@-%@-%@-%@",tf1.text,tf2.text,tf3.text,tf4.text,tf5.text,tf6.text,tv.text);
    
    [OWNetworking HPOST:wh_appendingStr(wh_host, @"mobile/hardMemberApply/add") parameters:par success:^(id  _Nullable responseObject) {
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
    return (indexPath.row < 6) ? 45.0f : 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 6) {
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
    }else if (indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5){
        
        NSArray *typeList = @[@"类型1",@"类型2"];
        [[OWPicker pickLinearData:typeList forView:self.view.window selectedBlock:^BOOL(BOOL isCancel, NSArray<NSString *> *selectedTitles, NSArray<NSNumber *> *indexs) {
            if (isCancel) return YES;
            OWDisInputCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.inputTF.text = selectedTitles[0];
            cell.input.content = selectedTitles[0];
            return YES;
        }] show:YES];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


#pragma mark - ---------- Lazy ----------

- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"提交申请" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.5f];
        [btn setBackgroundColor:wh_themeColor];
        [self.tableView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.tableView).offset(420);
            make.width.equalTo(self.view).multipliedBy(0.8);
            make.height.equalTo(45);
        }];
        btn.layer.cornerRadius = 4;
        _submitBtn = btn;
    }
    return _submitBtn;
}


@end
