//
//  OWRegisterPickerCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/12.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWRegisterPickerCell.h"

@interface OWRegisterPickerCell ()

@property (nonatomic, weak) UIButton *sexBtn;
@property (nonatomic, weak) UIButton *organizeBtn;
@property (nonatomic, weak) UIButton *dutyBtn;

@end

@implementation OWRegisterPickerCell

static NSString *const identifier = @"OWRegisterPickerCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWRegisterPickerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWRegisterPickerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        [self.dutyBtn wh_addActionHandler:^(UIButton *sender) {
            wh_Log(@"----点击了选择党内职务");
        }];
        
        [self.sexBtn wh_addActionHandler:^(UIButton *sender) {
            wh_Log(@"----点击选择了性别");
        }];
        
        [self.organizeBtn wh_addActionHandler:^(UIButton *sender) {
            wh_Log(@"----点击选择了组织支部");
        }];
    }
    return self;
}


#pragma mark - ---------- Lazy ----------

- (UIButton *)sexBtn
{
    if (!_sexBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"性别" forState:UIControlStateNormal];
        [btn setTitleColor:wh_norFontColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.5f];
        [btn setImage:wh_imageNamed(@"login_down") forState:UIControlStateNormal];
        [btn wh_setImagePosition:WHImagePositionRight spacing:10];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.layer.borderColor = wh_RGB(169, 169, 169).CGColor;
        btn.layer.borderWidth = 0.5;
        [self.contentView addSubview:btn];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.centerX).multipliedBy(0.2).offset(25);
            make.top.equalTo(self.dutyBtn);
            make.right.equalTo(self.dutyBtn.left).offset(-10);
            make.height.equalTo(self.dutyBtn);
        }];
        _sexBtn = btn;
    }
    return _sexBtn;
}


- (UIButton *)dutyBtn
{
    if (!_dutyBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"请选择党内职务" forState:UIControlStateNormal];
        [btn setTitleColor:wh_norFontColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.0f];
        [btn setImage:wh_imageNamed(@"login_down") forState:UIControlStateNormal];
        [btn wh_setImagePosition:WHImagePositionRight spacing:10];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.layer.borderColor = wh_RGB(169, 169, 169).CGColor;
        btn.layer.borderWidth = 0.5;
        [self.contentView addSubview:btn];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-25);
            make.top.equalTo(self).offset(25);
            make.width.equalTo(self).multipliedBy(0.55);
            make.height.equalTo(40);
        }];
        _dutyBtn = btn;
    }
    return _dutyBtn;
}

- (UIButton *)organizeBtn
{
    if (!_organizeBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"请选择组织支部" forState:UIControlStateNormal];
        [btn setTitleColor:wh_norFontColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.5f];
        [btn setImage:wh_imageNamed(@"login_down") forState:UIControlStateNormal];
        [btn wh_setImagePosition:WHImagePositionRight spacing:10];
        [btn setBackgroundColor:[UIColor whiteColor]];
        btn.layer.borderColor = wh_RGB(169, 169, 169).CGColor;
        btn.layer.borderWidth = 0.5;
        [self.contentView addSubview:btn];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.right.height.equalTo(self.dutyBtn);
            make.left.equalTo(self.sexBtn);
            make.top.equalTo(self.dutyBtn.bottom).offset(15);
        }];
        _organizeBtn = btn;
    }
    return _organizeBtn;
}

@end
