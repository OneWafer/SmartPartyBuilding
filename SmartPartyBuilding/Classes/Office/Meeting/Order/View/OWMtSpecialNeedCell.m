//
//  OWMtSpecialNeedCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/21.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWMtSpecialNeedCell.h"

@interface OWMtSpecialNeedCell ()

@property (nonatomic, weak) UIButton *needBtn;
@property (nonatomic, weak) UIButton *numBtn;

@end

@implementation OWMtSpecialNeedCell

static NSString *const identifier = @"OWMtSpecialNeedCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWMtSpecialNeedCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWMtSpecialNeedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        [self.needBtn setTitle:@"身体不舒服专用躺椅" forState:UIControlStateNormal];
        [self.needBtn wh_setImagePosition:WHImagePositionRight spacing:5];
        
        [self.numBtn setTitle:@"12" forState:UIControlStateNormal];
        [self.numBtn wh_setImagePosition:WHImagePositionRight spacing:5];
    }
    return self;
}

#pragma mark - ---------- Lazy ----------

- (UIButton *)needBtn
{
    if (!_needBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:wh_norFontColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setImage:wh_imageNamed(@"office_down") forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(15);
            make.height.equalTo(self).multipliedBy(0.6);
            make.width.equalTo(self).multipliedBy(0.4);
        }];
        
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = wh_lineColor.CGColor;
        _needBtn = btn;
    }
    return _needBtn;
}

- (UIButton *)numBtn
{
    if (!_numBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:wh_norFontColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setImage:wh_imageNamed(@"office_down") forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.height.equalTo(self.needBtn);
            make.left.equalTo(self.needBtn.right).offset(20);
            make.width.equalTo(self).multipliedBy(0.2);
        }];
        
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = wh_lineColor.CGColor;
        _numBtn = btn;
    }
    return _numBtn;
}
@end
