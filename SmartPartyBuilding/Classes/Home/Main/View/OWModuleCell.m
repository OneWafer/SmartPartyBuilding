//
//  OWModuleCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/19.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWModuleCell.h"

@interface OWModuleCell ()

@property (nonatomic, weak) UIButton *volunteerBtn;
@property (nonatomic, weak) UIButton *donationBtn;
@property (nonatomic, weak) UIButton *storeBtn;

@end

@implementation OWModuleCell

static NSString *const identifier = @"OWModuleCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWModuleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWModuleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        [self.volunteerBtn setBackgroundColor:[UIColor grayColor]];
        [self.donationBtn setBackgroundColor:[UIColor grayColor]];
        [self.storeBtn setBackgroundColor:[UIColor grayColor]];
        
        [self.volunteerBtn wh_addActionHandler:^(UIButton *sender) {
            wh_Log(@"点击了志愿大厅");
        }];
        
        [self.donationBtn wh_addActionHandler:^(UIButton *sender) {
            wh_Log(@"点击了爱心捐赠");
        }];
        
        [self.storeBtn wh_addActionHandler:^(UIButton *sender) {
            wh_Log(@"点击了积分商城");
        }];
    }
    return self;
}


#pragma mark - ---------- Lazy ----------

- (UIButton *)volunteerBtn
{
    if (!_volunteerBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"志愿大厅" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setImage:wh_imageNamed(@"home_arrow_white") forState:UIControlStateNormal];
        [btn wh_setImagePosition:WHImagePositionRight spacing:0];
        [self.contentView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self).offset(10);
            make.width.equalTo((wh_screenWidth - 30)*0.5);
            make.height.equalTo((wh_screenWidth - 30)*0.45);
        }];
        _volunteerBtn = btn;
    }
    return _volunteerBtn;
}

- (UIButton *)donationBtn
{
    if (!_donationBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"爱心捐赠" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setImage:wh_imageNamed(@"home_arrow_white") forState:UIControlStateNormal];
        [btn wh_setImagePosition:WHImagePositionRight spacing:0];
        [self.contentView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.volunteerBtn);
            make.right.equalTo(self).offset(-10);
            make.width.height.equalTo(self.volunteerBtn);
        }];
        _donationBtn = btn;
    }
    return _donationBtn;
}

- (UIButton *)storeBtn
{
    if (!_storeBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"积分积分商城" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setImage:wh_imageNamed(@"home_arrow_white") forState:UIControlStateNormal];
        [btn wh_setImagePosition:WHImagePositionRight spacing:0];
        [self.contentView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.top.equalTo(self.volunteerBtn.bottom).offset(10);
            make.right.bottom.equalTo(self).offset(-10);
        }];
        _storeBtn = btn;
    }
    return _storeBtn;
}

@end
