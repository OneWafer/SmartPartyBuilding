//
//  OWDisInputViewCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/15.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <ReactiveCocoa.h>
#import "OWDisInputViewCell.h"
#import "OWDisInput.h"

@interface OWDisInputViewCell ()

@property (nonatomic, weak) UILabel *placeLabel;
@property (nonatomic, weak) UIView *lineView;
@end

@implementation OWDisInputViewCell

static NSString *const identifier = @"OWDisInputViewCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWDisInputViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWDisInputViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        self.lineView.backgroundColor = wh_lineColor;
    }
    return self;
}


- (void)setInput:(OWDisInput *)input
{
    _input = input;
    self.placeLabel.text = input.place;
    wh_weakSelf(self);
    [self.inputView.rac_textSignal subscribeNext:^(NSString *x) {
        weakself.input.content = x;
        weakself.placeLabel.hidden = x.length;
    }];
}

#pragma mark - ---------- Lazy ----------


- (UIView *)inputView
{
    if (!_inputView) {
        UITextView *tv = [[UITextView alloc] init];
        tv.font = [UIFont systemFontOfSize:14.5f];
        [self.contentView addSubview:tv];
        
        [tv makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(12);
            make.right.equalTo(self).offset(-12);
            make.top.bottom.equalTo(self);
        }];
        _inputView = tv;
    }
    return _inputView;
}

- (UILabel *)placeLabel
{
    if (!_placeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_RGB(199, 199, 199);
        label.font = [UIFont systemFontOfSize:14.5f];
        [self.inputView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.inputView).offset(5);
            make.top.equalTo(self.inputView).offset(7);
        }];
        _placeLabel = label;
    }
    return _placeLabel;
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
