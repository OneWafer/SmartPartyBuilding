//
//  OWForgetVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/13.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "OWForgetVC.h"
#import "OWRegisterInputCell.h"
#import "OWRegister.h"
#import "OWNetworking.h"

@interface OWForgetVC ()

@property (nonatomic, strong) NSArray *registerList;
//@property (nonatomic, copy) NSString *verCode;

@end

@implementation OWForgetVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"忘记密码";
    
    wh_weakSelf(self);
    [self.tableView wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself.view endEditing:YES];
    }];
    
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
    self.tableView.scrollEnabled = NO;
    NSArray *list = @[
                      @{@"image":@"login_act", @"place":@"请输入手机号"},
                      @{@"image":@"login_ver", @"place":@"请输入验证码"},
                      @{@"image":@"login_pwd", @"place":@"请输入密码"},
                      @{@"image":@"", @"place":@"再次输入密码"}
                      ];
    self.registerList = [OWRegister mj_objectArrayWithKeyValuesArray:list];
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
//            self.verCode = responseObject[@"data"];
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
    if (r1.content.length && r2.content.length && r3.content.length && r4.content.length) {
        if ([r3.content isEqualToString:r4.content]) {
            NSDictionary *par = @{
                                  @"phoneNumber":r1.content,
                                  @"validCode":r2.content,
                                  @"password":r3.content
                                  };
            wh_Log(@"---%@",par);
            [OWNetworking POST:wh_appendingStr(wh_host, @"mobile/changePassword") parameters:par success:^(id  _Nullable responseObject) {
                wh_Log(@"----%@",responseObject);
                if ([responseObject[@"code"] intValue] == 200) {
                    [SVProgressHUD showSuccessWithStatus:@"修改成功!"];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
                }
            } failure:^(NSError * _Nonnull error) {
                [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
                wh_Log(@"---%@",error);
            }];
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
    return 50.0f;
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
    OWRegisterInputCell *cell = [OWRegisterInputCell cellWithTableView:tableView];
    cell.regist = self.registerList[indexPath.row];
    cell.block = ^(){
        [weakself getVerCode];
    };
    return cell;
    
}

@end
