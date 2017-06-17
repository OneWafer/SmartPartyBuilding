//
//  OWPartyFeeConfCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/16.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWPartyFeeConfCell.h"

@interface OWPartyFeeConfCell ()

@property (nonatomic, weak) UIView *titleView;
@property (nonatomic, weak) UILabel *startLabel;
@property (nonatomic, weak) UILabel *monthNumLabel;
@property (nonatomic, weak) UILabel *moneyLabel;
@property (nonatomic, weak) UILabel *nextLabel;
@property (nonatomic, weak) UIView *lineView;

@end

@implementation OWPartyFeeConfCell

static NSString *const identifier = @"OWPartyFeeConfCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWPartyFeeConfCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWPartyFeeConfCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        self.titleView.backgroundColor = [UIColor whiteColor];
        self.startLabel.text = @"2017-05";
        self.monthNumLabel.text = @"0";
        self.moneyLabel.text = @"0.0";
        self.nextLabel.text = @"2017-05";
        self.lineView.backgroundColor = wh_lineColor;
    }
    return self;
}


#pragma mark - ---------- Lazy ----------

- (UIView *)titleView
{
    if (!_titleView) {
        UIView *view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.equalTo(self).multipliedBy(0.5);
        }];
        _titleView = view;
        
        UILabel *startLabel = [[UILabel alloc] init];
        startLabel.text = @"缴纳月份";
        startLabel.textColor = wh_norFontColor;
        startLabel.font = [UIFont systemFontOfSize:14.0f];
        [view addSubview:startLabel];
        [startLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view).multipliedBy(1.2);
            make.centerX.equalTo(view).multipliedBy(0.25);
        }];
        
        UILabel *monthNumLabel = [[UILabel alloc] init];
        monthNumLabel.text = @"缴纳月数";
        monthNumLabel.textColor = wh_norFontColor;
        monthNumLabel.font = [UIFont systemFontOfSize:14.0f];
        [view addSubview:monthNumLabel];
        [monthNumLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(startLabel);
            make.centerX.equalTo(view).multipliedBy(0.75);
        }];
        
        UILabel *moneyLabel = [[UILabel alloc] init];
        moneyLabel.text = @"缴纳金额";
        moneyLabel.textColor = wh_norFontColor;
        moneyLabel.font = [UIFont systemFontOfSize:14.0f];
        [view addSubview:moneyLabel];
        [moneyLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(startLabel);
            make.centerX.equalTo(view).multipliedBy(1.25);
        }];
        
        
        UILabel *nextLabel = [[UILabel alloc] init];
        nextLabel.text = @"下次缴纳";
        nextLabel.textColor = wh_norFontColor;
        nextLabel.font = [UIFont systemFontOfSize:14.0f];
        [view addSubview:nextLabel];
        [nextLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(startLabel);
            make.centerX.equalTo(view).multipliedBy(1.75);
        }];
        
        
        _titleView = view;
    }
    return _titleView;
}

- (UILabel *)startLabel
{
    if (!_startLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_RGB(0, 177, 236);
        label.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:label];
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self).multipliedBy(1.3);
            make.centerX.equalTo(self).multipliedBy(0.25);
        }];
        _startLabel = label;
    }
    return _startLabel;
}

- (UILabel *)monthNumLabel
{
    if (!_monthNumLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_RGB(0, 177, 236);
        label.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:label];
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.startLabel);
            make.centerX.equalTo(self).multipliedBy(0.75);
        }];
        _monthNumLabel = label;
    }
    return _monthNumLabel;
}

- (UILabel *)moneyLabel
{
    if (!_moneyLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_RGB(0, 177, 236);
        label.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:label];
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.startLabel);
            make.centerX.equalTo(self).multipliedBy(1.25);
        }];
        _moneyLabel = label;
    }
    return _moneyLabel;
}

- (UILabel *)nextLabel
{
    if (!_nextLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_RGB(0, 177, 236);
        label.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:label];
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.startLabel);
            make.centerX.equalTo(self).multipliedBy(1.75);
        }];
        _nextLabel = label;
    }
    return _nextLabel;
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
