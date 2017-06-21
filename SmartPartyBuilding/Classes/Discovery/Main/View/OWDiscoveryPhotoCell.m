//
//  OWDiscoveryPhotoCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/16.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "OWDiscoveryPhotoCell.h"

@interface OWDiscoveryPhotoCell ()

@property (nonatomic, weak) UIImageView *titleImgView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIImageView *contentImgView;

@end

@implementation OWDiscoveryPhotoCell

static NSString *const identifier = @"OWDiscoveryPhotoCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWDiscoveryPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWDiscoveryPhotoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    self.titleImgView.image = wh_imageNamed(optionDic[@"image"]);
    self.titleLabel.text = optionDic[@"title"];
    [self.contentImgView sd_setImageWithURL:[NSURL URLWithString:optionDic[@"content"]] placeholderImage:wh_imageNamed(@"")];
}

#pragma mark - ---------- Lazy ----------

- (UIImageView *)titleImgView
{
    if (!_titleImgView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(15);
        }];
        _titleImgView = imgView;
    }
    return _titleImgView;
}


- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:14.5f];
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.titleImgView.right).offset(10);
        }];
        _titleLabel = label;
    }
    return _titleLabel;
}


- (UIImageView *)contentImgView
{
    if (!_contentImgView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-35);
            make.width.height.equalTo(self.height).multipliedBy(0.7);
        }];
        _contentImgView = imgView;
    }
    return _contentImgView;
}

@end
