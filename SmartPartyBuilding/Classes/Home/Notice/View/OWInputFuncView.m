//
//  OWInputFuncView.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/25.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <ReactiveCocoa.h>
#import "OWInputFuncView.h"
#import "UIButton+Badge.h"

@interface OWInputFuncView ()<UITextFieldDelegate>

@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *collectionBtn;
@property (nonatomic, weak) UIButton *thumbupBtn;

@end

@implementation OWInputFuncView

- (instancetype)init
{
    if ([super init]) {
        
        wh_weakSelf(self);
        [self.inputView.rac_textSignal subscribeNext:^(id x) {
            self.commentStr = x;
        }];
        
        
        [self.thumbupBtn wh_addActionHandler:^(UIButton *sender) {
            sender.selected = !sender.selected;
            wh_Log(@"点击了点赞");
            if (weakself.block) weakself.block(11);
        }];
        
        [self.collectionBtn wh_addActionHandler:^(UIButton *sender) {
            sender.selected = !sender.selected;
            wh_Log(@"点击了收藏");
            if (weakself.block) weakself.block(12);
        }];
        
        [self.commentBtn wh_addActionHandler:^(UIButton *sender) {
            wh_Log(@"点击了评论");
            if (weakself.block) weakself.block(13);
        }];
        
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.block) self.block(10);
    return YES;
}

- (void)setCount:(NSInteger)count
{
    _count = count;
    self.commentBtn.badgeValue = [NSString stringWithFormat:@"%ld",(long)count];
    self.commentBtn.badgeBGColor = wh_RGB(28, 184, 235);
    self.commentBtn.badgeOriginX = 24.0f;
    self.commentBtn.badgeOriginY = 1.0f;
}

#pragma mark - ---------- Lazy ----------

- (UIView *)inputView
{
    if (!_inputView) {
        UITextField *tf = [[UITextField alloc] init];
        tf.placeholder = @"说说你的看法";
        tf.textColor = wh_norFontColor;
        tf.font = [UIFont systemFontOfSize:14.0f];
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.returnKeyType = UIReturnKeyDone;
        tf.delegate = self;
        [self addSubview:tf];
        
        [tf makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(10);
            make.height.equalTo(self).multipliedBy(0.7);
            make.width.equalTo(wh_screenWidth - 150);
        }];
        _inputView = tf;
    }
    return _inputView;
}

- (UIButton *)thumbupBtn
{
    if (!_thumbupBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:wh_imageNamed(@"home_thumbup") forState:UIControlStateNormal];
        [btn setImage:wh_imageNamed(@"home_thumbup_slt") forState:UIControlStateSelected];
        [self addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self);
            make.width.equalTo(45);
        }];
        _thumbupBtn = btn;
    }
    return _thumbupBtn;
}

- (UIButton *)collectionBtn
{
    if (!_collectionBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:wh_imageNamed(@"home_collection") forState:UIControlStateNormal];
        [btn setImage:wh_imageNamed(@"home_collection_slt") forState:UIControlStateSelected];
        [self addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.top.width.bottom.equalTo(self.thumbupBtn);
            make.right.equalTo(self.thumbupBtn.left);
        }];
        _collectionBtn = btn;
    }
    return _collectionBtn;
}

- (UIButton *)commentBtn
{
    if (!_commentBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:wh_imageNamed(@"home_collection") forState:UIControlStateNormal];
        [self addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.top.width.bottom.equalTo(self.thumbupBtn);
            make.right.equalTo(self.collectionBtn.left);
        }];
        _commentBtn = btn;
    }
    return _commentBtn;
}


@end
