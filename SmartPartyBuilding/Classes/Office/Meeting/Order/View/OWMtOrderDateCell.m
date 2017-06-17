//
//  OWMtOrderDateCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/5.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWMtOrderDateCell.h"

@interface OWMtOrderDateCell ()

@property (nonatomic, weak) UIView *startView;
@property (nonatomic, weak) UIView *endView;

@end

@implementation OWMtOrderDateCell

static NSString *const identifier = @"OWMtOrderDateCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWMtOrderDateCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWMtOrderDateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        UILabel *centerLabel = [[UILabel alloc] init];
        centerLabel.text = @"~";
        [self.contentView addSubview:centerLabel];
        [centerLabel makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        wh_weakSelf(self);
        self.startLabel.text = [NSDate wh_getCurrentTimeWithFormat:@"yyyy-MM-dd HH:mm"];
        self.endLabel.text = [NSDate wh_getCurrentTimeWithFormat:@"yyyy-MM-dd HH:mm"];
        [self.startView wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            if (weakself.block) weakself.block(11);
        }];
        
        [self.endView wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            if (weakself.block) weakself.block(12);
        }];
    }
    return self;
}

#pragma mark - ---------- Lazy ----------

- (UIView *)startView
{
    if (!_startView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self.centerX).offset(-15);
        }];
        view.layer.borderColor = wh_lineColor.CGColor;
        view.layer.borderWidth = 0.5f;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"开始";
        titleLabel.textColor = wh_RGB(9, 131, 216);
        titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [view addSubview:titleLabel];
        [titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view);
            make.centerY.equalTo(view).multipliedBy(0.6);
        }];
        _startView = view;
    }
    return _startView;
}

- (UILabel *)startLabel
{
    if (!_startLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_norFontColor;
        label.font = [UIFont systemFontOfSize:14.0f];
        [self.startView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.startView);
            make.centerY.equalTo(self.startView).multipliedBy(1.4);
        }];
        _startLabel = label;
    }
    return _startLabel;
}


- (UIView *)endView
{
    if (!_endView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.width.equalTo(self.startView);
            make.right.equalTo(self).offset(-15);
        }];
        view.layer.borderColor = wh_lineColor.CGColor;
        view.layer.borderWidth = 0.5f;
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"结束";
        titleLabel.textColor = wh_RGB(217, 17, 22);
        titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [view addSubview:titleLabel];
        [titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view);
            make.centerY.equalTo(view).multipliedBy(0.6);
        }];
        _endView = view;
    }
    return _endView;
}


- (UILabel *)endLabel
{
    if (!_endLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_norFontColor;
        label.font = [UIFont systemFontOfSize:14.0f];
        [self.endView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.endView);
            make.centerY.equalTo(self.endView).multipliedBy(1.4);
        }];
        _endLabel = label;
    }
    return _endLabel;
}

@end
