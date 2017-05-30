//
//  OWMtOrderInputCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/21.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWMtOrderInputCell.h"

@interface OWMtOrderInputCell ()

@property (nonatomic, weak) UILabel *placeLabel;
@property (nonatomic, weak) UITextView *inputView;

@end

@implementation OWMtOrderInputCell

static NSString *const identifier = @"OWMtOrderInputCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWMtOrderInputCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWMtOrderInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    }
    return self;
}

- (void)setPlaceStr:(NSString *)placeStr
{
    _placeStr = placeStr;
    self.placeLabel.text = placeStr;
}

#pragma mark - ---------- Lazy ----------


- (UIView *)inputView
{
    if (!_inputView) {
        UITextView *tv = [[UITextView alloc] init];
        tv.backgroundColor = [UIColor whiteColor];
        tv.font = [UIFont systemFontOfSize:12.0f];
        [self.contentView addSubview:tv];
        
        [tv makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
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
        label.textColor = wh_RGB(169, 169, 169);
        label.font = [UIFont systemFontOfSize:12.0f];
        [self.inputView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.inputView).offset(5);
            make.top.equalTo(self.inputView).offset(7);
        }];
        _placeLabel = label;
    }
    return _placeLabel;
}

@end
