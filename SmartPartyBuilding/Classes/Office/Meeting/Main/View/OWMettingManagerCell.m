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
        [self.titleImgView sd_setImageWithURL:[NSURL URLWithString:@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1495261196&di=56aced13ab7e0100367f7915bdabb21f&src=http://pic.qiantucdn.com/58pic/17/90/31/55a7ec43230f2_1024.jpg"] placeholderImage:wh_imageNamed(@"")];
        self.titleLabel.text = @"会议室A10-320";
        self.detailLabel.text = @"可容纳180人";
        self.statusLabel.text = @"使用中";
        self.statusLabel.textColor = [UIColor redColor];
        
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
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
