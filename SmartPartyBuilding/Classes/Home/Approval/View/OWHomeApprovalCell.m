//
//  OWHomeApprovalCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/25.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWHomeApprovalCell.h"

@interface OWHomeApprovalCell ()

@property (nonatomic, weak) UIImageView *hotImgView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UILabel *statuslLabel;
@property (nonatomic, weak) UIView *btmLineView;

@end

@implementation OWHomeApprovalCell

static NSString *const identifier = @"OWHomeApprovalCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWHomeApprovalCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWHomeApprovalCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        self.titleLabel.text = @"庆祝开发区登山活动圆满结束!!";
        self.timeLabel.text = @"刚刚";
        self.statuslLabel.text = @"已批";
        self.btmLineView.backgroundColor = wh_lineColor;
    }
    return self;
}


#pragma mark - ---------- Lazy ----------

- (UIImageView *)hotImgView
{
    if (!_hotImgView) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:wh_imageNamed(@"")];
        [self.contentView addSubview:imgView];
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(15);
        }];
        _hotImgView = imgView;
    }
    return _hotImgView;
}


- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(15);
        }];
        _titleLabel = label;
    }
    return _titleLabel;
}


- (UILabel *)statuslLabel
{
    if (!_statuslLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_RGB(9, 131, 216);
        label.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-15);
        }];
        _statuslLabel = label;
    }
    return _statuslLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_RGB(169, 169, 169);
        label.font = [UIFont systemFontOfSize:9.0f];
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.statuslLabel.left).offset(-10);
        }];
        _timeLabel = label;
    }
    return _timeLabel;
}


- (UIView *)btmLineView
{
    if (!_btmLineView) {
        UIView *view = [[UIView alloc] init];
        //        view.backgroundColor = wh_lineColor;
        [self.contentView addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self);
            make.height.equalTo(0.5);
        }];
        _btmLineView = view;
    }
    return _btmLineView;
}


@end
