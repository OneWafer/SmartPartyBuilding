//
//  OWMtAddDeviceCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/21.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWMtAddDeviceCell.h"

@interface OWMtAddDeviceCell ()

@property (nonatomic, weak) UIButton *addBtn;

@end

@implementation OWMtAddDeviceCell

static NSString *const identifier = @"OWMtAddDeviceCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWMtAddDeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWMtAddDeviceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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

- (void)setTitle:(NSString *)title
{
    _title = title;
    [self.addBtn setTitle:title forState:UIControlStateNormal];
    [self.addBtn wh_setImagePosition:WHImagePositionRight spacing:5];
}

#pragma mark - ---------- Lazy ----------

- (UIButton *)addBtn
{
    if (!_addBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:wh_norFontColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        [btn setImage:wh_imageNamed(@"office_add") forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(15);
            make.right.equalTo(self).offset(-15);
            make.height.equalTo(self).multipliedBy(0.6);
        }];
        
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = wh_lineColor.CGColor;
        _addBtn = btn;
    }
    return _addBtn;
}

@end
