//
//  OWRegisterInputCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/11.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <ReactiveCocoa.h>
#import "OWRegisterInputCell.h"
#import "OWRegister.h"

@interface OWRegisterInputCell ()

@property (nonatomic, weak) UIImageView *titleImgView;
@property (nonatomic, weak) UITextField *inputTF;
@property (nonatomic, weak) UIButton *verBtn;
@property (nonatomic, weak) UIView *lineView;

@end

@implementation OWRegisterInputCell

static NSString *const identifier = @"OWRegisterInputCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWRegisterInputCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWRegisterInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


/*
 *  构造方法(在初始化对象的时候会调用)
 *  一般在这个方法中添加需要显示的子控件
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.lineView.backgroundColor = wh_lineColor;
    }
    return self;
}


- (void)setRegist:(OWRegister *)regist
{
    _regist = regist;
    wh_weakSelf(self);
    if (regist.image.length) self.titleImgView.image = wh_imageNamed(regist.image);
    self.inputTF.placeholder = regist.place;
    
    // 修改键盘样式
    if ([regist.place isEqualToString:@"请输入手机号"] || [regist.place isEqualToString:@"请输入验证码"]) {
        self.inputTF.keyboardType = UIKeyboardTypeNumberPad;
    }else if ([regist.place isEqualToString:@"请输入密码"] || [regist.place isEqualToString:@"再次输入密码"]){
        self.inputTF.keyboardType = UIKeyboardTypeASCIICapable;
    }else if ([regist.place isEqualToString:@"请输入身份证号(选填)"]){
        self.inputTF.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    }
    
    // 监听输入
    [self.inputTF.rac_textSignal subscribeNext:^(id x) {
        weakself.regist.content = x;
    }];
    
    if ([regist.place isEqualToString:@"请输入手机号"]) {
        
        [[self.inputTF rac_textSignal] subscribeNext:^(NSString *x) {
            if (x.length > 11) weakself.inputTF.text = [x substringToIndex:11];
        }];
        
        [self.inputTF remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleImgView);
            make.left.equalTo(self.titleImgView.centerX).offset(25);
            make.right.equalTo(self).offset(-80);
        }];
        
        [self.verBtn wh_addActionHandler:^(UIButton *sender) {
            [sender wh_startTime:60 title:@"重新发送" waitTittle:@""];
            if (weakself.block) weakself.block();
        }];
    }
}

#pragma mark - ---------- Lazy ----------

- (UIImageView *)titleImgView
{
    if (!_titleImgView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).multipliedBy(1.2);
            make.centerX.equalTo(self).multipliedBy(0.2);
        }];
        _titleImgView = imgView;
    }
    return _titleImgView;
}


- (UITextField *)inputTF
{
    if (!_inputTF) {
        UITextField *tf = [[UITextField alloc] init];
        tf.font = [UIFont systemFontOfSize:14.5f];
        tf.tintColor = wh_norFontColor;
        [self.contentView addSubview:tf];
        
        [tf makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleImgView);
            make.left.equalTo(self.titleImgView.centerX).offset(25);
            make.right.equalTo(self).offset(-25);
        }];
        _inputTF = tf;
    }
    return _inputTF;
}

- (UIView *)lineView
{
    if (!_lineView) {
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.inputTF);
            make.right.equalTo(self).offset(-25);
            make.bottom.equalTo(self);
            make.height.equalTo(0.7);
        }];
        _lineView = view;
    }
    return _lineView;
}

- (UIButton *)verBtn
{
    if (!_verBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"验证码" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:wh_RGB(155, 155, 155) forState:UIControlStateDisabled];
        btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [btn setBackgroundColor:wh_RGB(27, 184, 235)];
        btn.layer.cornerRadius = 4;
        [self.contentView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.titleImgView);
            make.right.equalTo(self.lineView);
            make.width.equalTo(52);
            make.height.equalTo(24);
        }];
        _verBtn = btn;
    }
    return _verBtn;
}
@end
