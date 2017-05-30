//
//  OWCommodityItemCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/29.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "OWCommodityItemCell.h"

@interface OWCommodityItemCell ()

@property (nonatomic, weak) UIImageView *titleImgView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *remainLabel;
@property (nonatomic, weak) UIButton *addBtn;

@end

@implementation OWCommodityItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self.titleImgView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496635915&di=184dc5d94ebe166a437c412364e8818b&imgtype=jpg&er=1&src=http%3A%2F%2Fruanwenpic.b0.upaiyun.com%2Fueditor%2Fupyun%2F20170118%2F1484716972298812.png"] placeholderImage:wh_imageNamed(@"")];
        self.titleLabel.text = @"心纯净，行至美的怡宝心纯净，行至美的怡宝";
        self.remainLabel.text = @"剩余999瓶";
        
        wh_weakSelf(self);
        [self.addBtn wh_addActionHandler:^(UIButton *sender) {
            if (weakself.block) weakself.block();
        }];
    }
    return self;
}

#pragma mark - ---------- Lazy ----------

- (UIImageView *)titleImgView
{
    if (!_titleImgView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.equalTo(self).multipliedBy(0.73);
        }];
        _titleImgView = imgView;
    }
    return _titleImgView;
}


- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:13.0f];
        label.textColor = wh_norFontColor;
        label.numberOfLines = 2;
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.equalTo(self.titleImgView.bottom).offset(5);
            make.right.equalTo(self).offset(-10);
            
        }];
        _titleLabel = label;
    }
    return _titleLabel;
}


- (UILabel *)remainLabel
{
    if (!_remainLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_RGB(169, 169, 169);
        label.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:label];
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel);
            make.bottom.equalTo(self).offset(-5);
        }];
        _remainLabel = label;
    }
    return _remainLabel;
}

- (UIButton *)addBtn
{
    if (!_addBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"添加" forState:UIControlStateNormal];
        [btn setTitleColor:wh_norFontColor forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:btn];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-10);
            make.bottom.equalTo(self).offset(-5);
            make.width.equalTo(45);
            make.height.equalTo(20);
        }];
        
        btn.layer.cornerRadius = 3;
        btn.layer.borderColor = wh_RGB(149, 149, 149).CGColor;
        btn.layer.borderWidth = 1.0f;
        _addBtn = btn;
    }
    return _addBtn;
}

@end
