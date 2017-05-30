//
//  OWMeetingOrderCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/20.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWMeetingOrderCell.h"

@interface OWMeetingOrderCell ()

@property (nonatomic, weak) UIView *verLineView;
@property (nonatomic, weak) UIView *bgView;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UILabel *descLabel;

@end

@implementation OWMeetingOrderCell

static NSString *const identifier = @"OWMeetingOrderCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWMeetingOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWMeetingOrderCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        self.backgroundColor = [UIColor clearColor];
        self.verLineView.backgroundColor = wh_lineColor;
        self.bgView.backgroundColor = [UIColor whiteColor];
        self.timeLabel.text = @"12:00 - 16:30";
        self.contentLabel.text = @"会议内容 : 去宝华山见客户要很晚回来";
        self.descLabel.text = @"会议描述 : 张二二、张一二、张五、李四";
    }
    return self;
}


#pragma mark - ---------- Lazy ----------

- (UIView *)verLineView
{
    if (!_verLineView) {
        UIView *view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(27);
            make.top.bottom.equalTo(self);
            make.width.equalTo(1);
        }];
        _verLineView = view;
    }
    return _verLineView;
}


- (UIView *)bgView
{
    if (!_bgView) {
        UIView *view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.verLineView.right).offset(10);
            make.top.equalTo(self).offset(5);
            make.bottom.equalTo(self).offset(-5);
            make.right.equalTo(self).offset(-15);
        }];
        _bgView = view;
    }
    return _bgView;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_norFontColor;
        label.font = [UIFont systemFontOfSize:12.0f];
        label.numberOfLines = 0;
        [self.bgView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.bgView).offset(10);
        }];
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_norFontColor;
        label.font = [UIFont systemFontOfSize:12.0f];
        label.numberOfLines = 0;
        [self.bgView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeLabel);
            make.top.equalTo(self.timeLabel.bottom).offset(5);
            make.width.equalTo(self.bgView).multipliedBy(0.8);
        }];
        _contentLabel = label;
    }
    return _contentLabel;
}

- (UILabel *)descLabel
{
    if (!_descLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_norFontColor;
        label.font = [UIFont systemFontOfSize:12.0f];
        label.numberOfLines = 0;
        [self.bgView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeLabel);
            make.top.equalTo(self.contentLabel.bottom).offset(5);
            make.width.equalTo(self.contentLabel);
        }];
        _descLabel = label;
    }
    return _descLabel;
}
@end
