//
//  OWSignatureCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/27.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <ReactiveCocoa.h>
#import "OWSignatureCell.h"

@interface OWSignatureCell ()

@property (nonatomic, weak) UILabel *placeLabel;

@end

@implementation OWSignatureCell

static NSString *const identifier = @"OWSignatureCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWSignatureCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWSignatureCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        self.placeLabel.text = @"请输入个性签名";
        wh_weakSelf(self);
        [self.inputView.rac_textSignal subscribeNext:^(NSString *x) {
            weakself.placeLabel.hidden = x.length;
        }];
    }
    return self;
}


#pragma mark - ---------- Lazy ----------

- (UIView *)inputView
{
    if (!_inputView) {
        UITextView *tv = [[UITextView alloc] init];
        tv.backgroundColor = [UIColor whiteColor];
        tv.font = [UIFont systemFontOfSize:13.5f];
        [self.contentView addSubview:tv];
        
        [tv makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
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
