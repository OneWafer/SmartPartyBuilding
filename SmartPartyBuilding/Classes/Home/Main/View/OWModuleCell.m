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

@property (nonatomic, weak) UIView *donationView;
@property (nonatomic, weak) UIView *storeView;
@property (nonatomic, weak) UIView *lineView;

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
        
        [self.donationView wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            wh_Log(@"点击了爱心捐赠");
        }];
        
        [self.storeView wh_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            wh_Log(@"点击了积分商城");
        }];
        self.lineView.backgroundColor = wh_lineColor;
    }
    return self;
}


#pragma mark - ---------- Lazy ----------

//- (UIView *)volunteerView
//{
//    if (!_volunteerView) {
//        UIView *view = [[UIView alloc] init];
//        view.backgroundColor = [UIColor whiteColor];
//        [self.contentView addSubview:view];
//        
//        [view makeConstraints:^(MASConstraintMaker *make) {
//            make.left.top.equalTo(self).offset(10);
//            make.width.equalTo((wh_screenWidth - 30)*0.5);
//            make.height.equalTo((wh_screenWidth - 30)*0.45);
//        }];
//        
//        UIImageView *imgView = [[UIImageView alloc] initWithImage:wh_imageNamed(@"home_volunteer_img")];
//        [view addSubview:imgView];
//        [imgView makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(view);
//            make.centerY.equalTo(view).multipliedBy(0.8);
//            make.width.equalTo(view).multipliedBy(0.65);
//            make.height.equalTo(view).multipliedBy(0.635);
//        }];
//        
//        UIImageView *btn = [[UIImageView alloc] initWithImage:wh_imageNamed(@"home_volunteer_btn")];
//        [view addSubview:btn];
//        [btn makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(view);
//            make.centerY.equalTo(view).multipliedBy(1.7);
//            make.width.equalTo(view).multipliedBy(0.57);
//            make.height.equalTo(view).multipliedBy(0.166);
//        }];
//        
//        _volunteerView = view;
//    }
//    return _volunteerView;
//}


- (UIView *)donationView
{
    if (!_donationView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self);
            make.width.equalTo(self).multipliedBy(0.5);
        }];
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:wh_imageNamed(@"home_donation_img")];
        [view addSubview:imgView];
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view);
            make.centerY.equalTo(view).multipliedBy(0.8);
        }];
        
        UIImageView *btn = [[UIImageView alloc] initWithImage:wh_imageNamed(@"home_donation_btn")];
        [view addSubview:btn];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view);
            make.centerY.equalTo(view).multipliedBy(1.7);;
        }];
        
        _donationView = view;
    }
    return _donationView;
}


- (UIView *)storeView
{
    if (!_storeView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self);
            make.width.equalTo(self).multipliedBy(0.5);
        }];
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:wh_imageNamed(@"home_store_img")];
        [view addSubview:imgView];
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view);
            make.centerY.equalTo(view).multipliedBy(0.8);
        }];
        
        UIImageView *btn = [[UIImageView alloc] initWithImage:wh_imageNamed(@"home_store_btn")];
        [view addSubview:btn];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(view);
            make.centerY.equalTo(view).multipliedBy(1.7);;
        }];
        
        _storeView = view;
    }
    return _storeView;
}

- (UIView *)lineView
{
    if (!_lineView) {
        UIView *view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.equalTo(0.5);
            make.height.equalTo(self).multipliedBy(0.8);
        }];
        _lineView = view;
    }
    return _lineView;
}

@end
