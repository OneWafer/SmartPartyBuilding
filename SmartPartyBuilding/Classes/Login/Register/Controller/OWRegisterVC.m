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
#import "OWLoginBranchVC.h"
#import "OWRegisterInputCell.h"
#import "OWRegisterPickerCell.h"
#import "OWRegister.h"
#import "OWNetworking.h"
#import "OWBranch.h"
#import "OWPicker.h"

@interface OWRegisterVC ()

@property (nonatomic, strong) NSArray *registerList;
@property (nonatomic, strong) NSArray *branchList;
@property (nonatomic, strong) NSArray *dutyList;
@property (nonatomic, copy) NSString *verCode;

@end

@implementation OWRegisterVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置背景透明图片
    [self.navigationController.navigationBar setValue:@0 forKeyPath:@"backgroundView.alpha"];
}

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
        [weakself.view endEditing:YES];
        [weakself dataSubmit];
    }];
}

- (void)setupTableView
{
    self.tableView.separatorStyle = NO;
    CGFloat bottomEdge = 600.0f - wh_screenHeight;
    if (bottomEdge <= 0) bottomEdge = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, bottomEdge, 0);
    NSArray *list = @[
                      @{@"image":@"login_act", @"place":@"请输入手机号", @"content":@""},
                      @{@"image":@"login_ver", @"place":@"请输入验证码", @"content":@""},
                      @{@"image":@"login_pwd", @"place":@"请输入密码", @"content":@""},
                      @{@"image":@"", @"place":@"再次输入密码", @"content":@""},
                      @{@"image":@"login_name", @"place":@"请输入姓名/昵称", @"content":@""},
                      @{@"image":@"login_id", @"place":@"请输入身份证号(选填)", @"content":@""},
                      @{@"sex":@(0), @"duty":@"", @"organize":@(0)}
                      ];
    self.registerList = [OWRegister mj_objectArrayWithKeyValuesArray:list];
}


/** 获取所有支部 */
- (void)dataRequest
{
    [OWNetworking GET:wh_appendingStr(wh_host, @"mobile/branchInfo/listAll") parameters:nil success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            self.branchList = [OWBranch mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
        wh_Log(@"---%@",error);
        
    }];
    
    [OWNetworking GET:wh_appendingStr(wh_host, @"mobile/listPartyPosition") parameters:nil success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            self.dutyList = [responseObject[@"data"] wh_map:^id(NSDictionary *obj) {
                return obj[@"name"];
            }];
            wh_Log(@"---%@",self.dutyList);
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
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
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
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
    OWRegister *r7 = self.registerList[6];
    wh_Log(@"---%@",r6.content);
    if (r1.content.length && r2.content.length && r3.content.length && r4.content.length && r5.content.length && r7.duty.length && (r7.sex >= 0) && (r7.organize >= 0)) {
        if ([r3.content isEqualToString:r4.content]) {
            if (!r6.content.length || (r6.content.length && [NSString wh_accurateVerifyIDCardNumber:r6.content])) {
                NSDictionary *par = @{
                                      @"phoneNumber":r1.content,
                                      @"validCode":r2.content,
                                      @"password":r3.content,
                                      @"staffName":r5.content,
                                      @"identityId":r6.content,
                                      @"sex":@(r7.sex),
                                      @"partyPosition":r7.duty,
                                      @"partyBranchId":@(r7.organize)
                                      };
                [OWNetworking POST:wh_appendingStr(wh_host, @"mobile/register") parameters:par success:^(id  _Nullable responseObject) {
                    wh_Log(@"----%@",responseObject);
                    if ([responseObject[@"code"] intValue] == 200) {
                        [SVProgressHUD showSuccessWithStatus:@"注册成功!"];
                        [self.navigationController popViewControllerAnimated:YES];
                    }else{
                        [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
                    }
                } failure:^(NSError * _Nonnull error) {
                    [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
                    wh_Log(@"---%@",error);
                }];
            }else{
                [SVProgressHUD showInfoWithStatus:@"请填写有效身份证号!"];
            }
        }else{
            [SVProgressHUD showInfoWithStatus:@"密码输入不一致!"];
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
    wh_weakSelf(self);
    if (indexPath.row < 6) {
        OWRegisterInputCell *cell = [OWRegisterInputCell cellWithTableView:tableView];
        cell.regist = self.registerList[indexPath.row];
        cell.block = ^(){
            [weakself getVerCode];
        };
        return cell;
    }else{
        OWRegister *regist = self.registerList[indexPath.row];
        OWRegisterPickerCell *cell = [OWRegisterPickerCell cellWithTableView:tableView];
        __weak OWRegisterPickerCell *weakCell = cell;
        
        cell.block = ^(NSInteger tag){
            [weakself.view endEditing:YES];
            if (tag == 11) {
                [[OWPicker pickLinearData:self.dutyList forView:self.view.window selectedBlock:^BOOL(BOOL isCancel, NSArray<NSString *> *selectedTitles, NSArray<NSNumber *> *indexs) {
                    if (isCancel) return YES;
                    [weakCell.dutyBtn setTitle:selectedTitles[0] forState:UIControlStateNormal];
                    [weakCell.dutyBtn wh_setImagePosition:WHImagePositionRight spacing:10];
                    regist.duty = selectedTitles[0];
                    return YES;
                }] show:YES];
            }else if (tag == 12){
                NSArray *typeList = @[@"男",@"女"];
                [[OWPicker pickLinearData:typeList forView:self.view.window selectedBlock:^BOOL(BOOL isCancel, NSArray<NSString *> *selectedTitles, NSArray<NSNumber *> *indexs) {
                    if (isCancel) return YES;
                    [weakCell.sexBtn setTitle:selectedTitles[0] forState:UIControlStateNormal];
                    [weakCell.sexBtn wh_setImagePosition:WHImagePositionRight spacing:8];
                    regist.sex = [selectedTitles[0] isEqualToString:@"男"] ? 0 : 1;
                    return YES;
                }] show:YES];
            }else{
                OWLoginBranchVC *branchVC = [[OWLoginBranchVC alloc] init];
                branchVC.branchList = self.branchList;
                branchVC.block = ^(OWBranch *branch){
                    [weakCell.organizeBtn setTitle:branch.organizationName forState:UIControlStateNormal];
                    regist.organize = branch.id;
                };
                [weakself.navigationController pushViewController:branchVC animated:YES];
            }
        };
        return cell;
    }
    
}

#pragma mark - ---------- Lazy ----------



@end
