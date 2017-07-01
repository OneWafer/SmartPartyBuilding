//
//  OWItemHeaderCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/21.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "OWItemHeaderCell.h"
#import "OWStoreItem.h"

@interface OWItemHeaderCell ()

@property (nonatomic, weak) UIImageView *titleImgView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *priceLabel;
@property (nonatomic, weak) UIButton *addBtn;


@end

@implementation OWItemHeaderCell

static NSString *const identifier = @"OWItemHeaderCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWItemHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWItemHeaderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        wh_weakSelf(self);
        [self.addBtn wh_addActionHandler:^(UIButton *sender) {
            if (weakself.block) weakself.block();
        }];
    }
    return self;
}

- (void)setItem:(OWStoreItem *)item
{
    _item = item;
    [self.titleImgView sd_setImageWithURL:[NSURL URLWithString:item.avatar] placeholderImage:wh_imageNamed(@"home_banner_place")];
    self.titleLabel.text = item.itemName;
    self.priceLabel.text = [NSString stringWithFormat:@"%d积分",item.integral ?: 0];
}


#pragma mark - ---------- Lazy ----------

- (UIImageView *)titleImgView
{
    if (!_titleImgView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.equalTo(self).multipliedBy(0.8);
        }];
        _titleImgView = imgView;
    }
    return _titleImgView;
}


- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.textColor = wh_norFontColor;
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self.titleImgView.bottom).offset(7);
            make.width.equalTo(self).multipliedBy(0.7);
            
        }];
        _titleLabel = label;
    }
    return _titleLabel;
}


- (UILabel *)priceLabel
{
    if (!_priceLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_RGB(169, 169, 169);
        label.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:label];
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel);
            make.bottom.equalTo(self).offset(-5);
        }];
        _priceLabel = label;
    }
    return _priceLabel;
}

- (UIButton *)addBtn
{
    if (!_addBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"立即兑换" forState:UIControlStateNormal];
        [btn setTitleColor:wh_norFontColor forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [self.contentView addSubview:btn];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-15);
            make.centerY.equalTo(self).multipliedBy(1.8);
            make.width.equalTo(68);
            make.height.equalTo(22);
        }];
        
        btn.layer.cornerRadius = 3;
        btn.layer.borderColor = wh_RGB(149, 149, 149).CGColor;
        btn.layer.borderWidth = 1.0f;
        _addBtn = btn;
    }
    return _addBtn;
}

@end
