//
//  OWMomLocationCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/7/28.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "OWMomLocationCell.h"

@interface OWMomLocationCell ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *detailLabel;
@property (nonatomic, weak) UIView *lineView;

@end

@implementation OWMomLocationCell

static NSString *const identifier = @"OWMomLocationCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWMomLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWMomLocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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

- (void)setPoi:(AMapPOI *)poi
{
    _poi = poi;
    self.titleLabel.text = poi.name;
    self.detailLabel.text = poi.address;
}

#pragma mark - ---------- Lazy ----------

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_norFontColor;
        label.font = [UIFont systemFontOfSize:16.0f];
        [self.contentView addSubview:label];
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self).multipliedBy(0.6);
        }];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_RGB(159, 159, 159);
        label.font = [UIFont systemFontOfSize:12.0f];
        [self.contentView addSubview:label];
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self).multipliedBy(1.5);
        }];
        _detailLabel = label;
    }
    return _detailLabel;
}

- (UIView *)lineView
{
    if (!_lineView) {
        UIView *view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self);
            make.height.equalTo(0.5);
        }];
        _lineView = view;
    }
    return _lineView;
}

@end
