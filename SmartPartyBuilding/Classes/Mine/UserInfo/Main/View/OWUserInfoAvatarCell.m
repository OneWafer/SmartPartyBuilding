//
//  OWUserInfoAvatarCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/16.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "OWUserInfoAvatarCell.h"

@interface OWUserInfoAvatarCell ()

@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation OWUserInfoAvatarCell

static NSString *const identifier = @"OWUserInfoAvatarCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWUserInfoAvatarCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWUserInfoAvatarCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }
    return self;
}


- (void)setOptionDic:(NSDictionary *)optionDic
{
    _optionDic = optionDic;
    self.titleLabel.text = optionDic[@"title"];
    [self.avatarImgView sd_setImageWithURL:[NSURL URLWithString:optionDic[@"content"]] placeholderImage:wh_imageNamed(@"home_news_place")];
    
}

#pragma mark - ---------- Lazy ----------

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14.5f];
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(15);
        }];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIImageView *)avatarImgView
{
    if (!_avatarImgView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-35);
            make.width.height.equalTo(self.height).multipliedBy(0.75);
        }];
        _avatarImgView = imgView;
    }
    return _avatarImgView;
}
@end
