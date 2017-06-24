//
//  OWDisInputCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/15.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <ReactiveCocoa.h>
#import "OWDisInputCell.h"
#import "OWDisInput.h"

@interface OWDisInputCell ()

@property (nonatomic, weak) UIButton *pickBtn;
@property (nonatomic, weak) UIView *lineView;

@end

@implementation OWDisInputCell

static NSString *const identifier = @"OWDisInputCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWDisInputCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWDisInputCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    wh_weakSelf(self);
    self.inputTF.placeholder = input.place;
    self.inputTF.text = input.content;
    // 监听输入
    [self.inputTF.rac_textSignal subscribeNext:^(id x) {
        weakself.input.content = x;
    }];
    
    self.inputTF.userInteractionEnabled = !([input.place isEqualToString:@"出生年月"] || [input.place isEqualToString:@"入党日期"] || [input.place isEqualToString:@"困难类型"] || [input.place isEqualToString:@"是否享受低保"] || [input.place isEqualToString:@"是否享受抚恤"] || [input.place isEqualToString:@"文化程度"] || [input.place isEqualToString:@"可提供服务时间"]);
    
}

#pragma mark - ---------- Lazy ----------

- (UITextField *)inputTF
{
    if (!_inputTF) {
        UITextField *tf = [[UITextField alloc] init];
        tf.textColor = wh_norFontColor;
        tf.font = [UIFont systemFontOfSize:14.5f];
        [self.contentView addSubview:tf];
        
        [tf makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.top.bottom.equalTo(self);
        }];
        _inputTF = tf;
    }
    return _inputTF;
}


- (UIButton *)pickBtn
{
    if (!_pickBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        _pickBtn = btn;
    }
    return _pickBtn;
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
