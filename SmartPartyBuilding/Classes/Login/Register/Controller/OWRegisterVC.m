//
//  OWRegisterVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/24.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <ReactiveCocoa.h>
#import "OWRegisterVC.h"

@interface OWRegisterVC ()

@property (nonatomic, weak) UIImageView *bgImgView;
@property (nonatomic, weak) UIView *inputView;
@property (nonatomic, weak) UITextField *telTF;
@property (nonatomic, weak) UIButton *verBtn;
@property (nonatomic, weak) UITextField *verTF;
@property (nonatomic, weak) UITextField *nameTF;
@property (nonatomic, weak) UITextField *idTF;
@property (nonatomic, weak) UIButton *sexBtn;
@property (nonatomic, weak) UIButton *organizeBtn;
@property (nonatomic, weak) UIButton *dutyBtn;
@end

@implementation OWRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"注册";
    
    [self setupNavi];
    [self setupInputView];
    
}

- (void)setupNavi
{
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem wh_itemWithType:WHItemTypeRight norTitle:@"提交" font:15.0f norColor:[UIColor whiteColor] highColor:[UIColor whiteColor] offset:0 actionHandler:^(UIButton *sender) {
        wh_Log(@"---点击了注册");
    }];
}

- (void)setupInputView
{
    RACSignal *loginSignal = [RACSignal combineLatest:@[self.telTF.rac_textSignal] reduce:^id(NSString *tel){
        return @(tel.length == 11);
    }];
    
    RAC(self.verBtn, enabled) = loginSignal;
    
    [self.verBtn wh_addActionHandler:^(UIButton *sender) {
        [sender wh_startTime:60 title:@"重新发送" waitTittle:@""];
    }];
    
    self.verTF.text = @"";
    self.nameTF.text = @"";
    self.idTF.text = @"";
    
    [self.organizeBtn wh_addActionHandler:^(UIButton *sender) {
        wh_Log(@"---点击了选择组织支部");
    }];
    
    [self.sexBtn wh_addActionHandler:^(UIButton *sender) {
        wh_Log(@"---点击了选择性别");
    }];
    
    [self.dutyBtn wh_addActionHandler:^(UIButton *sender) {
        wh_Log(@"---点击了选择党内职务");
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


- (UIView *)inputView
{
    if (!_inputView) {
        self.bgImgView.image = [UIImage wh_imgWithColor:[UIColor redColor]];
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.width.equalTo(self.view);
            make.height.equalTo(400);
            make.centerY.equalTo(self.view);
        }];
        _inputView = view;
    }
    return _inputView;
}


- (UITextField *)telTF
{
    if (!_telTF) {
        UITextField *tf = [[UITextField alloc] init];
        tf.placeholder = @"请输入手机号";
        tf.font = [UIFont systemFontOfSize:14.0f];
        tf.tintColor = wh_RGB(109, 109, 109);
        tf.backgroundColor = [UIColor whiteColor];
        tf.layer.borderColor = wh_RGB(169, 169, 169).CGColor;
        tf.layer.borderWidth = 0.5;
        tf.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.keyboardType = UIKeyboardTypeNumberPad;
        [self.inputView addSubview:tf];
        
        [tf makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.inputView).offset(wh_screenWidth * 0.1);
            make.top.equalTo(self.inputView);
            make.width.equalTo(self.inputView).multipliedBy(0.55);
            make.height.equalTo(45);
        }];
        _telTF = tf;
    }
    return _telTF;
}


- (UIButton *)verBtn
{
    if (!_verBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"验证码" forState:UIControlStateNormal];
        [btn setTitleColor:wh_RGB(217, 17, 22) forState:UIControlStateNormal];
        [btn setTitleColor:wh_RGB(199, 199, 199) forState:UIControlStateDisabled];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.layer.borderColor = wh_RGB(169, 169, 169).CGColor;
        btn.layer.borderWidth = 0.5;
        [self.inputView addSubview:btn];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.height.equalTo(self.telTF);
            make.left.equalTo(self.telTF.right).offset(15);
            make.right.equalTo(self.inputView).offset(-wh_screenWidth * 0.1);
        }];
        _verBtn = btn;
    }
    return _verBtn;
}

- (UITextField *)verTF
{
    if (!_verTF) {
        UITextField *tf = [[UITextField alloc] init];
        tf.placeholder = @"请输入验证码";
        tf.font = [UIFont systemFontOfSize:14.0f];
        tf.tintColor = wh_RGB(109, 109, 109);
        tf.backgroundColor = [UIColor whiteColor];
        tf.layer.borderColor = wh_RGB(169, 169, 169).CGColor;
        tf.layer.borderWidth = 0.5;
        tf.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.keyboardType = UIKeyboardTypeNumberPad;
        [self.inputView addSubview:tf];
        
        [tf makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.inputView);
            make.top.equalTo(self.telTF.bottom).offset(20);
            make.width.equalTo(self.inputView).multipliedBy(0.8);
            make.height.equalTo(self.telTF);
        }];
        _verTF = tf;
    }
    return _verTF;
}

- (UITextField *)nameTF
{
    if (!_nameTF) {
        UITextField *tf = [[UITextField alloc] init];
        tf.placeholder = @"请输入姓名/昵称";
        tf.font = [UIFont systemFontOfSize:14.0f];
        tf.tintColor = wh_RGB(109, 109, 109);
        tf.backgroundColor = [UIColor whiteColor];
        tf.layer.borderColor = wh_RGB(169, 169, 169).CGColor;
        tf.layer.borderWidth = 0.5;
        tf.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        tf.leftViewMode = UITextFieldViewModeAlways;
        [self.inputView addSubview:tf];
        
        [tf makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.verTF);
            make.top.equalTo(self.verTF.bottom).offset(20);
            make.width.equalTo(self.inputView).multipliedBy(0.8);
            make.height.equalTo(self.telTF);
        }];
        _nameTF = tf;
    }
    return _nameTF;
}


- (UITextField *)idTF
{
    if (!_idTF) {
        UITextField *tf = [[UITextField alloc] init];
        tf.placeholder = @"请输入身份证号码";
        tf.font = [UIFont systemFontOfSize:14.0f];
        tf.tintColor = wh_RGB(109, 109, 109);
        tf.backgroundColor = [UIColor whiteColor];
        tf.layer.borderColor = wh_RGB(169, 169, 169).CGColor;
        tf.layer.borderWidth = 0.5;
        tf.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        tf.leftViewMode = UITextFieldViewModeAlways;
        tf.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        [self.inputView addSubview:tf];
        
        [tf makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.verTF);
            make.top.equalTo(self.nameTF.bottom).offset(20);
            make.width.equalTo(self.inputView).multipliedBy(0.8);
            make.height.equalTo(self.telTF);
        }];
        _idTF = tf;
    }
    return _idTF;
}

- (UIButton *)sexBtn
{
    if (!_sexBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"性别" forState:UIControlStateNormal];
        [btn setTitleColor:wh_norFontColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [btn setImage:wh_imageNamed(@"login_down") forState:UIControlStateNormal];
        [btn wh_setImagePosition:WHImagePositionRight spacing:10];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.layer.borderColor = wh_RGB(169, 169, 169).CGColor;
        btn.layer.borderWidth = 0.5;
        [self.inputView addSubview:btn];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.organizeBtn);
            make.right.equalTo(self.organizeBtn.left).offset(-15);
            make.left.equalTo(self.inputView).offset(wh_screenWidth * 0.1);
            make.height.equalTo(self.telTF);
        }];
        _sexBtn = btn;
    }
    return _sexBtn;
}

- (UIButton *)organizeBtn
{
    if (!_organizeBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"请选择组织支部" forState:UIControlStateNormal];
        [btn setTitleColor:wh_norFontColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [btn setImage:wh_imageNamed(@"login_down") forState:UIControlStateNormal];
        [btn wh_setImagePosition:WHImagePositionRight spacing:10];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.layer.borderColor = wh_RGB(169, 169, 169).CGColor;
        btn.layer.borderWidth = 0.5;
        [self.inputView addSubview:btn];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.inputView).offset(-wh_screenWidth * 0.1);
            make.height.equalTo(self.telTF);
            make.top.equalTo(self.idTF.bottom).offset(20);
            make.width.equalTo(self.inputView).multipliedBy(0.55);
        }];
        _organizeBtn = btn;
    }
    return _organizeBtn;
}

- (UIButton *)dutyBtn
{
    if (!_dutyBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"请选择党内职务" forState:UIControlStateNormal];
        [btn setTitleColor:wh_norFontColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [btn setImage:wh_imageNamed(@"login_down") forState:UIControlStateNormal];
        [btn wh_setImagePosition:WHImagePositionRight spacing:10];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.layer.borderColor = wh_RGB(169, 169, 169).CGColor;
        btn.layer.borderWidth = 0.5;
        [self.inputView addSubview:btn];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.width.height.equalTo(self.verTF);
            make.top.equalTo(self.sexBtn.bottom).offset(20);
        }];
        _dutyBtn = btn;
    }
    return _dutyBtn;
}

@end
