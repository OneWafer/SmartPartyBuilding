//
//  OWSubmitCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/18.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWSubmitCell.h"

@interface OWSubmitCell ()

@property (nonatomic, weak) UIButton *submitBtn;

@end

@implementation OWSubmitCell

static NSString *const identifier = @"OWSubmitCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWSubmitCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWSubmitCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        wh_weakSelf(self);
        [self.submitBtn wh_addActionHandler:^(UIButton *sender) {
            if (weakself.block) weakself.block();
        }];
    }
    return self;
}


- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.submitBtn setTitle:title forState:UIControlStateNormal];
}

#pragma mark - ---------- Lazy ----------


- (UIButton *)submitBtn
{
    if (!_submitBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.5f];
        [btn setBackgroundColor:wh_themeColor];
        [self.contentView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.equalTo(self).multipliedBy(0.8);
            make.height.equalTo(45);
        }];
        btn.layer.cornerRadius = 4;
        _submitBtn = btn;
    }
    return _submitBtn;
}

@end
