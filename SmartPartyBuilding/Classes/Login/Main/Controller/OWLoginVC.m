//
//  OWLoginVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/23.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <ReactiveCocoa.h>
#import "OWLoginVC.h"
#import "OWRegisterVC.h"

@interface OWLoginVC ()<UITextFieldDelegate>

@property (nonatomic, weak) UIImageView *bgImgView;
@property (nonatomic, weak) UIImageView *logoImgView;
@property (nonatomic, weak) UIView *inputView;
@property (nonatomic, weak) UITextField *actTF;
@property (nonatomic, weak) UITextField *pwdTF;
@property (nonatomic, weak) UIButton *loginBtn;
@property (nonatomic, weak) UIButton *remeberBtn;
@property (nonatomic, weak) UIButton *forgetBtn;

@end

@implementation OWLoginVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置背景透明图片
    [self.navigationController.navigationBar setValue:@0 forKeyPath:@"backgroundView.alpha"];
}

//- (void)viewDidDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    [self.navigationController.navigationBar setValue:@1 forKeyPath:@"backgroundView.alpha"];
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setupNavi];
    [self setupInputView];
}


- (void)setupNavi
{
    wh_weakSelf(self);
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem wh_itemWithType:WHItemTypeRight norTitle:@"注册" font:15.0f norColor:[UIColor whiteColor] highColor:[UIColor whiteColor] offset:0 actionHandler:^(UIButton *sender) {
        OWRegisterVC *registerVC = [[OWRegisterVC alloc] init];
        [self.navigationController pushViewController:registerVC animated:YES];
    }];
}

- (void)setupInputView
{
//    [[self.actTF rac_textSignal] subscribeNext:^(NSString *x) {
//        if (x.length > 11) self.actTF.text = [x substringToIndex:11];
//    }];
    
    RACSignal *loginSignal = [RACSignal combineLatest:@[self.actTF.rac_textSignal,self.pwdTF.rac_textSignal] reduce:^id(NSString *account,NSString *pwd){
        return @(account.length == 11 && pwd.length);
    }];
    
    RAC(self.loginBtn, enabled) = loginSignal;
    
    [self.loginBtn wh_addActionHandler:^(UIButton *sender) {
        wh_Log(@"---点击了登录");
    }];
    
    [self.remeberBtn wh_addActionHandler:^(UIButton *sender) {
        wh_Log(@"---点击了记住密码");
    }];
    
    [self.forgetBtn wh_addActionHandler:^(UIButton *sender) {
        wh_Log(@"---点击了忘记密码");
    }];
}

#pragma mark - ---------- Lazy ----------

- (UIImageView *)bgImgView
{
    if (!_bgImgView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.view addSubview:imgView];
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        _bgImgView = imgView;
    }
    return _bgImgView;
}

- (UIImageView *)logoImgView
{
    if (!_logoImgView) {
        self.bgImgView.image = [UIImage wh_imgWithColor:[UIColor redColor]];
        UIImageView *imgView = [[UIImageView alloc] initWithImage:wh_imageNamed(@"login_logo")];
        [self.view addSubview:imgView];
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.centerY.equalTo(self.view).multipliedBy(0.45);
        }];
        _logoImgView = imgView;
    }
    return _logoImgView;
}

- (UIView *)inputView
{
    if (!_inputView) {
        self.logoImgView.image = wh_imageNamed(@"login_logo");
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.width.equalTo(self.view);
            make.height.equalTo(250);
            make.centerY.equalTo(self.view).multipliedBy(1.1);
        }];
        _inputView = view;
    }
    return _inputView;
}


- (UITextField *)actTF
{
    if (!_actTF) {
        UITextField *tf = [[UITextField alloc] init];
        tf.placeholder = @"账号/密码";
        tf.font = [UIFont systemFontOfSize:14.0f];
        tf.tintColor = wh_RGB(109, 109, 109);
        tf.backgroundColor = [UIColor whiteColor];
        tf.layer.borderColor = wh_RGB(169, 169, 169).CGColor;
        tf.layer.borderWidth = 0.5;
        tf.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        tf.leftViewMode = UITextFieldViewModeAlways;
        [self.inputView addSubview:tf];
        
        [tf makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.top.equalTo(self.inputView);
            make.width.equalTo(self.inputView).multipliedBy(0.8);
            make.height.equalTo(45);
        }];
        _actTF = tf;
    }
    return _actTF;
}

- (UITextField *)pwdTF
{
    if (!_pwdTF) {
        UITextField *tf = [[UITextField alloc] init];
        tf.placeholder = @"密码";
        tf.font = [UIFont systemFontOfSize:14.0f];
        tf.tintColor = wh_RGB(109, 109, 109);
        tf.backgroundColor = [UIColor whiteColor];
        tf.layer.borderColor = wh_RGB(169, 169, 169).CGColor;
        tf.layer.borderWidth = 0.5;
        tf.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        tf.leftViewMode = UITextFieldViewModeAlways;
        [self.inputView addSubview:tf];
        
        [tf makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.width.height.equalTo(self.actTF);
            make.top.equalTo(self.actTF.bottom).offset(20);
        }];
        _pwdTF = tf;
    }
    return _pwdTF;
}


- (UIButton *)loginBtn
{
    if (!_loginBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"登录" forState:UIControlStateNormal];
        [btn setTitleColor:wh_RGB(217, 17, 22) forState:UIControlStateNormal];
        [btn setTitleColor:wh_RGB(169, 169, 169) forState:UIControlStateDisabled];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [self.inputView addSubview:btn];
        btn.layer.cornerRadius = 3;
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.width.height.equalTo(self.actTF);
            make.top.equalTo(self.pwdTF.bottom).offset(20);
        }];
        _loginBtn = btn;
    }
    return _loginBtn;
}

- (UIButton *)remeberBtn
{
    if (!_remeberBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"记住用户名" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setImage:wh_imageNamed(@"") forState:UIControlStateNormal];
        [btn setImage:wh_imageNamed(@"") forState:UIControlStateSelected];
        [btn wh_setImagePosition:WHImagePositionLeft spacing:10];
        [self.inputView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.actTF.left);
            make.top.equalTo(self.loginBtn.bottom).offset(20);
        }];
        _remeberBtn = btn;
    }
    return _remeberBtn;
}

- (UIButton *)forgetBtn
{
    if (!_forgetBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"忘记密码" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [btn setTitleColor:wh_RGB(30, 209, 253) forState:UIControlStateNormal];
        [self.inputView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.actTF.right);
            make.centerY.equalTo(self.remeberBtn);
        }];
        _forgetBtn = btn;
    }
    return _forgetBtn;
}

@end