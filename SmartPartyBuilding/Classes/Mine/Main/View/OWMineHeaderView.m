//
//  OWMineHeaderView.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/15.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "OWMineHeaderView.h"
#import "OWTool.h"

@interface OWMineHeaderView ()

@property (nonatomic, weak) UIImageView *bgImgView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *telLabel;
@property (nonatomic, weak) UIButton *manageBtn;

@end

@implementation OWMineHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        NSDictionary *userInfo = [OWTool getUserInfo];
        self.bgImgView.image = [UIImage wh_imgWithColor:[UIColor redColor]];
        self.headImgView.image = wh_imageNamed(@"btn1");
        self.nameLabel.text = userInfo[@"staffName"] ?: @"";
        self.telLabel.text = userInfo[@"phoneNumber"] ?: @"";
        wh_weakSelf(self);
        [self.manageBtn wh_addActionHandler:^(UIButton *sender) {
            if (weakself.headerBlock) weakself.headerBlock(11);
        }];
        
        [self.headImgView wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            if (weakself.headerBlock) weakself.headerBlock(12);
        }];
        
    }
    return self;
}



#pragma mark - ---------- Lazy ----------

- (UIImageView *)bgImgView
{
    if (!_bgImgView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self addSubview:imgView];
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        _bgImgView = imgView;
    }
    return _bgImgView;
}


- (UIImageView *)headImgView
{
    if (!_headImgView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        imgView.userInteractionEnabled = YES;
        [self addSubview:imgView];
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).multipliedBy(1.1);
            make.left.equalTo(self).offset(15);
            make.width.height.equalTo(50);
        }];
        _headImgView = imgView;
    }
    return _headImgView;
}


- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:10];
        [self addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgView.right).offset(10);
            make.bottom.equalTo(self.headImgView.centerY).offset(-5);
        }];
        _nameLabel = label;
    }
    return _nameLabel;
}


- (UILabel *)telLabel
{
    if (!_telLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:10];
        [self addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.top.equalTo(self.headImgView.centerY).offset(5);
        }];
        _telLabel = label;
    }
    return _telLabel;
}


- (UIButton *)manageBtn
{
    if (!_manageBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitle:@"资料管理" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setImage:wh_imageNamed(@"mine_arrow_white") forState:UIControlStateNormal];
        [btn wh_setImagePosition:WHImagePositionRight spacing:0];
        [self addSubview:btn];
        _manageBtn = btn;
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.bottom.equalTo(self).offset(-5);
        }];
    }
    return _manageBtn;
}


@end
