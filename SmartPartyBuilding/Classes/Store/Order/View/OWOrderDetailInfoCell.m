//
//  OWOrderDetailInfoCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/21.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWOrderDetailInfoCell.h"

@interface OWOrderDetailInfoCell ()

@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *tellLabel;
@property (nonatomic, weak) UILabel *addrLabel;
@property (nonatomic, weak) UIView *lineView;

@end

@implementation OWOrderDetailInfoCell

static NSString *const identifier = @"OWOrderDetailInfoCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWOrderDetailInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWOrderDetailInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        self.nameLabel.text = @"张老汉";
        self.tellLabel.text = @"1391456789";
        self.addrLabel.text = @"江苏省句容市 开元大酒店二楼";
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        self.lineView.backgroundColor = wh_lineColor;
    }
    return self;
}


#pragma mark - ---------- Lazy ----------

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_norFontColor;
        label.font = [UIFont systemFontOfSize:14.5f];
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.top.equalTo(self).offset(10);
            make.width.equalTo(self).multipliedBy(0.4);
        }];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)tellLabel
{
    if (!_tellLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_norFontColor;
        label.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-40);
            make.centerY.equalTo(self.nameLabel);
        }];
        _tellLabel = label;
    }
    return _tellLabel;
}

- (UILabel *)addrLabel
{
    if (!_addrLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_RGB(139, 139, 139);
        label.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.bottom.equalTo(self).offset(-15);
            make.width.equalTo(self).multipliedBy(0.7);
        }];
        _addrLabel = label;
    }
    return _addrLabel;
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
