//
//  OWStoreItemCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/20.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "OWStoreItemCell.h"
#import "OWStoreItem.h"

@interface OWStoreItemCell ()

@property (nonatomic, weak) UIImageView *titleImgView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *remainLabel;

@end

@implementation OWStoreItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = wh_lineColor.CGColor;
        self.layer.borderWidth = 0.5f;
        
        
    }
    return self;
}

- (void)setItem:(OWStoreItem *)item
{
    _item = item;
    [self.titleImgView sd_setImageWithURL:[NSURL URLWithString:item.avatar] placeholderImage:wh_imageNamed(@"home_news_place")];
    self.titleLabel.text = item.itemName;
    self.remainLabel.text = [NSString stringWithFormat:@"剩余: %d",item.num];
}


#pragma mark - ---------- Lazy ----------

- (UIImageView *)titleImgView
{
    if (!_titleImgView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.equalTo(self).multipliedBy(0.75);
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
@end
