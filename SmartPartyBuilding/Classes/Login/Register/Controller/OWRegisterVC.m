//
//  OWRegisterVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/24.
//  Copyright © 2017年 王卫华. All rights reserved.
//

//#import <Masonry.h>
//#import <ReactiveCocoa.h>
#import "OWRegisterVC.h"
#import "OWRegisterInputCell.h"

@interface OWRegisterVC ()

@property (nonatomic, strong) NSArray *titleList;
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
    
    [self setupNavi];
    [self setupTableView];
    
}

- (void)setupNavi
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem wh_itemWithType:WHItemTypeRight norTitle:@"提交" font:15.0f norColor:[UIColor whiteColor] highColor:[UIColor whiteColor] offset:0 actionHandler:^(UIButton *sender) {
        wh_Log(@"---点击了注册");
    }];
}

- (void)setupTableView
{
    self.tableView.separatorStyle = NO;
    self.titleList = @[
                       @{@"image":@"login_act", @"place":@"请输入手机号"},
                       @{@"image":@"login_ver", @"place":@"请输入验证码"},
                       @{@"image":@"login_pwd", @"place":@"请输入秘密"},
                       @{@"image":@"", @"place":@"再次输入密码"},
                       @{@"image":@"login_name", @"place":@"请输入姓名/昵称"},
                       @{@"image":@"login_id", @"place":@"请输入身份证号码(选填)"},
                       ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] init];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWRegisterInputCell *cell = [OWRegisterInputCell cellWithTableView:tableView];
    cell.titleDic = _titleList[indexPath.row];
    return cell;
}

#pragma mark - ---------- Lazy ----------


//- (UIButton *)sexBtn
//{
//    if (!_sexBtn) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setTitle:@"性别" forState:UIControlStateNormal];
//        [btn setTitleColor:wh_norFontColor forState:UIControlStateNormal];
//        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
//        [btn setImage:wh_imageNamed(@"login_down") forState:UIControlStateNormal];
//        [btn wh_setImagePosition:WHImagePositionRight spacing:10];
//        [btn setBackgroundColor:[UIColor whiteColor]];
//        btn.layer.borderColor = wh_RGB(169, 169, 169).CGColor;
//        btn.layer.borderWidth = 0.5;
//        [self.inputView addSubview:btn];
//        [btn makeConstraints:^(MASConstraintMaker *make) {
//            make.center.equalTo(self.organizeBtn);
//            make.right.equalTo(self.organizeBtn.left).offset(-15);
//            make.left.equalTo(self.inputView).offset(wh_screenWidth * 0.1);
//            make.height.equalTo(self.telTF);
//        }];
//        _sexBtn = btn;
//    }
//    return _sexBtn;
//}
//
//- (UIButton *)organizeBtn
//{
//    if (!_organizeBtn) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setTitle:@"请选择组织支部" forState:UIControlStateNormal];
//        [btn setTitleColor:wh_norFontColor forState:UIControlStateNormal];
//        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
//        [btn setImage:wh_imageNamed(@"login_down") forState:UIControlStateNormal];
//        [btn wh_setImagePosition:WHImagePositionRight spacing:10];
//        [btn setBackgroundColor:[UIColor whiteColor]];
//        btn.layer.borderColor = wh_RGB(169, 169, 169).CGColor;
//        btn.layer.borderWidth = 0.5;
//        [self.inputView addSubview:btn];
//        [btn makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.inputView).offset(-wh_screenWidth * 0.1);
//            make.height.equalTo(self.telTF);
//            make.top.equalTo(self.idTF.bottom).offset(20);
//            make.width.equalTo(self.inputView).multipliedBy(0.55);
//        }];
//        _organizeBtn = btn;
//    }
//    return _organizeBtn;
//}
//
//- (UIButton *)dutyBtn
//{
//    if (!_dutyBtn) {
//        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setTitle:@"请选择党内职务" forState:UIControlStateNormal];
//        [btn setTitleColor:wh_norFontColor forState:UIControlStateNormal];
//        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
//        [btn setImage:wh_imageNamed(@"login_down") forState:UIControlStateNormal];
//        [btn wh_setImagePosition:WHImagePositionRight spacing:10];
//        [btn setBackgroundColor:[UIColor whiteColor]];
//        btn.layer.borderColor = wh_RGB(169, 169, 169).CGColor;
//        btn.layer.borderWidth = 0.5;
//        [self.inputView addSubview:btn];
//        [btn makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.width.height.equalTo(self.verTF);
//            make.top.equalTo(self.sexBtn.bottom).offset(20);
//        }];
//        _dutyBtn = btn;
//    }
//    return _dutyBtn;
//}

@end
