//
//  OWHomeCommentCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/26.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "OWHomeCommentCell.h"
#import "OWMsgComment.h"

@interface OWHomeCommentCell ()

@property (nonatomic, weak) UIImageView *headImgView;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UILabel *timeLabel;
@property (nonatomic, weak) UIView *lineView;

@end

@implementation OWHomeCommentCell

static NSString *const identifier = @"OWHomeCommentCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWHomeCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWHomeCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        self.lineView.backgroundColor = wh_lineColor;
    }
    return self;
}


- (void)setComment:(OWMsgComment *)comment
{
    _comment = comment;
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:comment.avatar] placeholderImage:wh_imageNamed(@"home_func_place")];
    self.nameLabel.text = comment.staffName;
    self.contentLabel.text = comment.content;
    self.timeLabel.text = comment.publishTime;
}

#pragma mark - ---------- Lazy ----------

- (UIImageView *)headImgView
{
    if (!_headImgView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(15);
            make.width.height.equalTo(self.height).multipliedBy(0.75);
        }];
        imgView.layer.cornerRadius = 33.75;
        imgView.layer.masksToBounds = YES;
        _headImgView = imgView;
    }
    return _headImgView;
}


- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_norFontColor;
        label.font = [UIFont systemFontOfSize:14.5f];
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.headImgView.right).offset(10);
            make.top.equalTo(self.headImgView);
            make.width.equalTo(self).multipliedBy(0.8);
        }];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_norFontColor;
        label.font = [UIFont systemFontOfSize:14.5f];
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.centerY.equalTo(self);
            make.width.equalTo(self).multipliedBy(0.8);
        }];
        _contentLabel = label;
    }
    return _contentLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_RGB(149, 149, 149);
        label.font = [UIFont systemFontOfSize:10.0f];
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel);
            make.bottom.equalTo(self.headImgView);
            make.width.equalTo(self).multipliedBy(0.8);
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
