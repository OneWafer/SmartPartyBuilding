//
//  OWRegisterVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/24.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <SVProgressHUD.h>
#import <ReactiveCocoa.h>
#import <MJExtension.h>
#import "OWRegisterVC.h"
#import "OWRegisterInputCell.h"
#import "OWRegisterPickerCell.h"
#import "OWRegister.h"
#import "OWNetworking.h"

@interface OWRegisterVC ()

@property (nonatomic, strong) NSArray *registerList;
@property (nonatomic, copy) NSString *verCode;

@end

@implementation OWRegisterVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"注册";
    
    wh_weakSelf(self);
    [self.tableView wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself.view endEditing:YES];
    }];
    
    [self dataRequest];
    [self setupNavi];
    [self setupTableView];
}

- (void)setupNavi
{
    wh_weakSelf(self);
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem wh_itemWithType:WHItemTypeRight norTitle:@"提交" font:15.0f norColor:wh_RGB(9, 131, 216) highColor:[UIColor blueColor] offset:0 actionHandler:^(UIButton *sender) {
        [weakself dataSubmit];
    }];
}

- (void)setupTableView
{
    self.tableView.separatorStyle = NO;
    self.tableView.scrollEnabled = NO;
    NSArray *list = @[
                      @{@"image":@"login_act", @"place":@"请输入手机号", @"content":@""},
                      @{@"image":@"login_ver", @"place":@"请输入验证码", @"content":@""},
                      @{@"image":@"login_pwd", @"place":@"请输入密码", @"content":@""},
                      @{@"image":@"", @"place":@"再次输入密码", @"content":@""},
                      @{@"image":@"login_name", @"place":@"请输入姓名/昵称", @"content":@""},
                      @{@"image":@"login_id", @"place":@"请输入身份证号(选填)", @"content":@""},
                      @{@"sex":@"", @"duty":@"", @"organize":@""}
                      ];
    self.registerList = [OWRegister mj_objectArrayWithKeyValuesArray:list];
}


/** 获取所有支部 */
- (void)dataRequest
{
    [OWNetworking GET:wh_appendingStr(wh_host, @"mobile/branchInfo/listAll") parameters:nil success:^(id  _Nullable responseObject) {
        wh_Log(@"---%@",responseObject);
        if ([responseObject[@"code"] intValue] == 200) {
            wh_Log(@"---%@",responseObject[@"data"]);
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
        wh_Log(@"---%@",error);
        
    }];
}

/** 获取验证码 */
- (void)getVerCode
{
    OWRegister *r = self.registerList[0];
    NSDictionary *par = @{
                          @"phoneNumber":r.content
                          };
    wh_Log(@"---%@",par);
    [OWNetworking GET:wh_appendingStr(wh_host, @"mobile/validCode") parameters:par success:^(id  _Nullable responseObject) {
        wh_Log(@"---%@",responseObject);
        if ([responseObject[@"code"] intValue] == 200) {
            self.verCode = responseObject[@"data"];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
        wh_Log(@"---%@",error);
        
    }];
}

/** 提交注册 */
- (void)dataSubmit
{
    OWRegister *r1 = self.registerList[0];
    OWRegister *r2 = self.registerList[1];
    OWRegister *r3 = self.registerList[2];
    OWRegister *r4 = self.registerList[3];
    OWRegister *r5 = self.registerList[4];
    OWRegister *r6 = self.registerList[5];
    if (r1.content.length && r2.content.length && r3.content.length && r4.content.length && r5.content.length && r6.content.length) {
        if ([r2.content isEqualToString:self.verCode]) {
            if ([r3.content isEqualToString:r4.content]) {
                
                NSDictionary *par = @{
                                      @"phoneNumber":r1.content,
                                      @"validCode":r2.content,
                                      @"password":r3.content,
                                      @"staffName":r5.content,
                                      @"identityId":r6.content,
                                      @"sex":@(0),
                                      @"partyPosition":@"阿拉啦",
                                      @"partyBranchId":@"南京支部"
                                      };
                wh_Log(@"---%@",par);
                [OWNetworking POST:wh_appendingStr(wh_host, @"mobile/register") parameters:par success:^(id  _Nullable responseObject) {
                    wh_Log(@"----%@",responseObject);
                    if ([responseObject[@"code"] intValue] == 200) {
                        [SVProgressHUD showSuccessWithStatus:@"注册成功!"];
                        [self.navigationController popViewControllerAnimated:YES];
                    }else{
                        [SVProgressHUD showInfoWithStatus:responseObject[@"message"]];
                    }
                } failure:^(NSError * _Nonnull error) {
                    [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
                    wh_Log(@"---%@",error);
                }];
                
            }else{
                [SVProgressHUD showInfoWithStatus:@"密码输入不一致!"];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"验证码输入有误!"];
        }
    }else{
        [SVProgressHUD showInfoWithStatus:@"请填写完整信息!"];
    }
    
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
        wh_weakSelf(self);
        cell.block = ^(){
            [weakself getVerCode];
        };
        return cell;
    }else{
        OWRegisterPickerCell *cell = [OWRegisterPickerCell cellWithTableView:tableView];
        return cell;
    }
    
}

#pragma mark - ---------- Lazy ----------



@end
