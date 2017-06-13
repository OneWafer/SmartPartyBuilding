//
//  OWLoginVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/23.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <SVProgressHUD.h>
#import <ReactiveCocoa.h>
#import "OWLoginVC.h"
#import "OWRegisterVC.h"
#import "OWForgetVC.h"
#import "AppDelegate.h"
#import "OWNetworking.h"
#import "OWTool.h"

@interface OWLoginVC ()<UITextFieldDelegate>

@property (nonatomic, weak) UIImageView *logoImgView;
@property (nonatomic, weak) UIView *inputView;
@property (nonatomic, weak) UITextField *actTF;
@property (nonatomic, weak) UITextField *pwdTF;
@property (nonatomic, weak) UIButton *loginBtn;
@property (nonatomic, weak) UIButton *registerBtn;
@property (nonatomic, weak) UIButton *forgetBtn;

@end

@implementation OWLoginVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置背景透明图片
    [self.navigationController.navigationBar setValue:@0 forKeyPath:@"backgroundView.alpha"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupInputView];
    
    wh_weakSelf(self);
    [self.view wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself.view endEditing:YES];
    }];
}


- (void)setupInputView
{
    wh_weakSelf(self);
    [[self.actTF rac_textSignal] subscribeNext:^(NSString *x) {
        if (x.length > 11) weakself.actTF.text = [x substringToIndex:11];
    }];
    
    RACSignal *loginSignal = [RACSignal combineLatest:@[self.actTF.rac_textSignal,self.pwdTF.rac_textSignal] reduce:^id(NSString *account,NSString *pwd){
        return @(account.length && pwd.length);
    }];
    
    RAC(self.loginBtn, enabled) = loginSignal;
    [self.loginBtn wh_addActionHandler:^(UIButton *sender) {
        [weakself Login];
    }];
    
    [self.registerBtn wh_addActionHandler:^(UIButton *sender) {
        OWRegisterVC *registerVC = [[OWRegisterVC alloc] init];
        [weakself.navigationController pushViewController:registerVC animated:YES];
    }];
    
    [self.forgetBtn wh_addActionHandler:^(UIButton *sender) {
        OWForgetVC *forgetVC = [[OWForgetVC alloc] init];
        [weakself.navigationController pushViewController:forgetVC animated:YES];
    }];
}

- (void)Login
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [SVProgressHUD showWithStatus:@"正在登录..."];
    
    NSDictionary *par = @{
                          @"username" : self.actTF.text,
                          @"password" : self.pwdTF.text,
                          @"deviceNumber" : @"aaaaaaaaaaaaaaaaaaaaaaaaa"
                          };
    [OWNetworking GET:wh_appendingStr(wh_host, @"mobile/login") parameters:par success:^(id  _Nullable responseObject) {
        wh_Log(@"--%@",responseObject);
        if ([responseObject[@"code"] intValue] == 200) {
            [OWTool setToken:responseObject[@"data"]];
            [SVProgressHUD showSuccessWithStatus:@"登录成功!"];
            [app tabBar];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
    }];
}


#pragma mark - ---------- Lazy ----------

- (UIImageView *)logoImgView
{
    if (!_logoImgView) {
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
        
        [self.view addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.centerY.equalTo(self.view).multipliedBy(1.1);
            make.width.equalTo(self.view).multipliedBy(0.75);
            make.height.equalTo(250);
        }];
        _inputView = view;
    }
    return _inputView;
}


- (UITextField *)actTF
{
    if (!_actTF) {
        
        UIImageView *actImgView = [[UIImageView alloc] initWithImage:wh_imageNamed(@"login_act")];
        [self.inputView addSubview:actImgView];
        [actImgView makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.equalTo(self.inputView);;
            make.width.equalTo(19.5);
        }];
        
        UITextField *tf = [[UITextField alloc] init];
        tf.placeholder = @"请输入手机号";
//        tf.keyboardType = UIKeyboardTypeNumberPad;
        tf.font = [UIFont systemFontOfSize:14.5f];
        tf.tintColor = wh_RGB(109, 109, 109);
        [self.inputView addSubview:tf];
        
        [tf makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(actImgView);
            make.left.equalTo(actImgView.right).offset(15);
            make.right.equalTo(self.inputView);
            make.height.equalTo(actImgView);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = wh_lineColor;
        [self.inputView addSubview:lineView];
        [lineView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(tf);
            make.top.equalTo(tf.bottom).offset(5);
            make.height.equalTo(0.7);
        }];
        
        _actTF = tf;
    }
    return _actTF;
}

- (UITextField *)pwdTF
{
    if (!_pwdTF) {
        
        UIImageView *pwdImgView = [[UIImageView alloc] initWithImage:wh_imageNamed(@"login_pwd")];
        [self.inputView addSubview:pwdImgView];
        [pwdImgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.inputView);
            make.top.equalTo(self.actTF.bottom).offset(30);
            make.width.equalTo(19.5);
        }];
        
        UITextField *tf = [[UITextField alloc] init];
        tf.placeholder = @"密码";
        tf.keyboardType = UIKeyboardTypeASCIICapable;
        tf.font = [UIFont systemFontOfSize:14.5f];
        tf.tintColor = wh_RGB(109, 109, 109);
        [self.inputView addSubview:tf];
        
        [tf makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.height.equalTo(self.actTF);
            make.centerY.equalTo(pwdImgView);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = wh_lineColor;
        [self.inputView addSubview:lineView];
        [lineView makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(tf);
            make.top.equalTo(tf.bottom).offset(5);
            make.height.equalTo(0.7);
        }];
        
        _pwdTF = tf;
    }
    return _pwdTF;
}


- (UIButton *)loginBtn
{
    if (!_loginBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"立即登录" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.5f];
        [btn setBackgroundColor:wh_RGB(215, 7, 7)];
        [self.inputView addSubview:btn];
        btn.layer.cornerRadius = 4;
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.width.equalTo(self.inputView);
            make.top.equalTo(self.pwdTF.bottom).offset(45);
            make.height.equalTo(43);
        }];
        _loginBtn = btn;
    }
    return _loginBtn;
}


- (UIButton *)registerBtn
{
    if (!_registerBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"立即注册" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.5f];
        [btn setTitleColor:wh_RGB(29, 184, 235) forState:UIControlStateNormal];
        [self.inputView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.inputView);
            make.top.equalTo(self.loginBtn.bottom).offset(20);
        }];
        _registerBtn = btn;
    }
    return _registerBtn;
}

- (UIButton *)forgetBtn
{
    if (!_forgetBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"忘记密码" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.5f];
        [btn setTitleColor:wh_RGB(101, 101, 101) forState:UIControlStateNormal];
        [self.inputView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.actTF.right);
            make.centerY.equalTo(self.registerBtn);
        }];
        _forgetBtn = btn;
    }
    return _forgetBtn;
}

@end
