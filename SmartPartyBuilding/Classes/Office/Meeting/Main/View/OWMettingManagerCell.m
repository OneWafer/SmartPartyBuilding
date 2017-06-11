//
//  OWMettingManagerCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/20.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "OWMettingManagerCell.h"
#import "OWMeeting.h"
#import "OWCar.h"

@interface OWMettingManagerCell ()

@property (nonatomic, weak) UIImageView *titleImgView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *detailLabel;
@property (nonatomic, weak) UILabel *statusLabel;

@end

@implementation OWMettingManagerCell

static NSString *const identifier = @"OWMettingManagerCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWMettingManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWMettingManagerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        
        self.statusLabel.text = @"使用中";
        self.statusLabel.textColor = [UIColor redColor];
        
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}


- (void)setCar:(OWCar *)car
{
    _car = car;
    NSArray *urlList = [car.imgs componentsSeparatedByString:@","];
    [self.titleImgView sd_setImageWithURL:[NSURL URLWithString:urlList[0]] placeholderImage:wh_imageNamed(@"home_news_place")];
    self.titleLabel.text = car.carNum;
    self.detailLabel.text = car.introduce;
}

- (void)setMeet:(OWMeeting *)meet
{
    _meet = meet;
    NSArray *urlList = [meet.imgs componentsSeparatedByString:@","];
    [self.titleImgView sd_setImageWithURL:[NSURL URLWithString:urlList[0]] placeholderImage:wh_imageNamed(@"home_news_place")];
    self.titleLabel.text = meet.name;
    self.detailLabel.text = meet.introduce;
}

#pragma mark - ---------- Lazy ----------

- (UIImageView *)titleImgView
{
    if (!_titleImgView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self);
            make.width.equalTo(self).multipliedBy(0.4);
        }];
        _titleImgView = imgView;
    }
    return _titleImgView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_norFontColor;
        label.font = [UIFont systemFontOfSize:14];
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleImgView.right).offset(10);
            make.top.equalTo(self).offset(10);
            make.width.equalTo(self).multipliedBy(0.4);
        }];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_RGB(169, 169, 169);
        label.font = [UIFont systemFontOfSize:11.0f];
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.equalTo(self.titleLabel);
            make.top.equalTo(self.titleLabel.bottom).offset(10);
        }];
        _detailLabel = label;
    }
    return _detailLabel;
}

- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:11.0f];
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.width.equalTo(self.titleLabel);
            make.bottom.equalTo(self).offset(-10);
        }];
        _statusLabel = label;
    }
    return _statusLabel;
}

@end
