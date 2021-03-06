//
//  OWDisVolVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/15.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "OWDisVolVC.h"
#import "OWDisInputCell.h"
#import "OWDisInputViewCell.h"
#import "OWSubmitCell.h"
#import "OWDisInput.h"
#import "OWNetworking.h"
#import "OWPicker.h"
#import "OWTool.h"

@interface OWDisVolVC ()

@property (nonatomic, strong) NSArray *inputList;

@end

@implementation OWDisVolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"志愿者申请";
    
    [self setupTableView];
}

/** 设置tableview */
- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = NO;
    
    NSDictionary *userInfo = [OWTool getUserInfo];
    NSArray *arr = @[
                     @{@"place":@"姓名", @"content":userInfo[@"staffName"] ?: @""},
                     @{@"place":@"出生年月", @"content":@""},
                     @{@"place":@"联系电话", @"content":@""},
                     @{@"place":@"文化程度", @"content":@""},
                     @{@"place":@"工作单位", @"content":@""},
                     @{@"place":@"专业或特长", @"content":@""},
                     @{@"place":@"志愿者经历", @"content":@""},
                     @{@"place":@"可提供服务时间", @"content":@""},
                     @{@"place":@"其他说明", @"content":@""}
                     ];
    
    self.inputList = [OWDisInput mj_objectArrayWithKeyValuesArray:arr];
}


- (void)dataSubmit
{
    [SVProgressHUD showWithStatus:@"正在提交..."];
//    UITextField *tf1 = [self.view viewWithTag:1001];
//    UITextField *tf2 = [self.view viewWithTag:1002];
//    UITextField *tf3 = [self.view viewWithTag:1003];
//    UITextField *tf4 = [self.view viewWithTag:1004];
//    UITextField *tf5 = [self.view viewWithTag:1005];
//    UITextField *tf6 = [self.view viewWithTag:1006];
//    UITextField *tf7 = [self.view viewWithTag:1007];
//    UITextField *tf8 = [self.view viewWithTag:1008];
//    UITextField *tv = [self.view viewWithTag:1009];
    
    NSDictionary *par = @{
                          @"name":[self.inputList[0] content],
//                          @"":tf2.text,
                          @"phoneNumber":[self.inputList[2] content],
//                          @"":tf4.text,
//                          @"":tf5.text,
                          @"specialty":[self.inputList[5] content],
//                          @"":tf7.text,
                          @"time":[self.inputList[7] content],
//                          @"":tv.text
                          };
    
//        wh_Log(@"---%@-%@-%@-%@-%@-%@-%@",tf1.text,tf2.text,tf3.text,tf4.text,tf5.text,tf6.text,tf7.text,tf8.text,tf6.text,tv.text);
    
    [OWNetworking HPOST:wh_appendingStr(wh_host, @"mobile/volunteer/apply") parameters:par success:^(id  _Nullable responseObject) {
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
    return self.inputList.count + 1;
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
    if (indexPath.row < 8) {
        return 45.0f;
    }else if (indexPath.row == 8){
        return 100.0f;
    }else{
        return 150.0f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 8) {
        OWDisInputCell *cell = [OWDisInputCell cellWithTableView:tableView];
        cell.inputTF.tag = 1001 + indexPath.row;
        cell.input = self.inputList[indexPath.row];
        return cell;
    }else if (indexPath.row == 8){
        OWDisInputViewCell *cell = [OWDisInputViewCell cellWithTableView:tableView];
        cell.inputView.tag = 1001 + indexPath.row;
        cell.input = self.inputList[indexPath.row];
        return cell;
    }else{
        OWSubmitCell *cell = [OWSubmitCell cellWithTableView:tableView];
        cell.title = @"提交申请";
        wh_weakSelf(self);
        cell.block = ^(){
            [weakself dataSubmit];
        };
        return cell;
    }
}


#pragma mark - ---------- TableViewDataDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        OWPicker *picker = [OWPicker pickDateForView:self.view.window initialDate:[NSDate date] selectedBlock:^BOOL(BOOL isCancel, NSDate *date) {
            if (isCancel) return YES;
            OWDisInputCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.inputTF.text = [date wh_getDateStringWithFormat:@"yyyy-MM-dd"];
            cell.input.content = [date wh_getDateStringWithFormat:@"yyyy-MM-dd"];
            return YES;
        }];
        [picker show:YES];
    }else if (indexPath.row == 3 || indexPath.row == 7){
        
        NSArray *typeList = (indexPath.row == 3) ? @[@"小学", @"初中", @"中专", @"高中", @"大专", @"本科", @"硕士", @"博士"] : @[@"周一~周五 全天", @"周一~周五 下班后", @"仅周六", @"周日  全天", @"节假日"];
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

@end
