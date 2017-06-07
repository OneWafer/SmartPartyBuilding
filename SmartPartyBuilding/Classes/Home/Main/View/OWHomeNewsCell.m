//
//  OWHomeNewsCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/4.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "OWHomeNewsCell.h"
#import "OWNews.h"

@interface OWHomeNewsCell ()

@property (nonatomic, weak) UIImageView *titleImgView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *statusImgView;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UIView *lineView;

@end

@implementation OWHomeNewsCell

static NSString *const identifier = @"OWHomeNewsCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWHomeNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWHomeNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        [self.titleImgView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496562563540&di=952c9499373376ab1d43a0b7fc6812b5&imgtype=0&src=http%3A%2F%2Fpic2.ooopic.com%2F12%2F54%2F06%2F44bOOOPICfe_1024.jpg"] placeholderImage:wh_imageNamed(@"")];
        
        self.statusImgView.image = wh_imageNamed(@"home_news_new");
        
        self.lineView.backgroundColor = wh_lineColor;
    }
    return self;
}


- (void)setNews:(OWNews *)news
{
    _news = news;
    self.titleLabel.text = news.title;
    self.timeLabel.text = news.releaseTime;
}

#pragma mark - ---------- Lazy ----------

- (UIImageView *)titleImgView
{
    if (!_titleImgView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self).offset(10);
            make.bottom.equalTo(self).offset(-10);
            make.width.equalTo(self).multipliedBy(0.3);
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
        label.font = [UIFont systemFontOfSize:14.0f];
        label.numberOfLines = 2;
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleImgView.right).offset(10);
            make.top.equalTo(self.titleImgView);
            make.right.equalTo(self).offset(-15);
        }];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIImageView *)statusImgView
{
    if (!_statusImgView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel);
            make.bottom.equalTo(self.titleImgView);
        }];
        _statusImgView = imgView;
    }
    return _statusImgView;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_RGB(149, 149, 149);
        label.font = [UIFont systemFontOfSize:10.0f];
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.titleLabel);
            make.bottom.equalTo(self.titleImgView);
        }];
        _timeLabel = label;
    }
    return _timeLabel;
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
