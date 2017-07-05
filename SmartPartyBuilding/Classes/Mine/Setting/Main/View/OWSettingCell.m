//
//  OWSettingCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/16.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWSettingCell.h"

@interface OWSettingCell ()

@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation OWSettingCell

static NSString *const identifier = @"OWSettingCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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


- (void)setTitleDic:(NSDictionary *)titleDic
{
    _titleDic = titleDic;
    self.titleLabel.text = titleDic[@"title"];
    if ([self.titleLabel.text isEqualToString:@"清理缓存"]) self.contentLabel.text = titleDic[@"content"];
}



#pragma mark - ---------- Lazy ----------

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_norFontColor;
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

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_RGB(109, 109, 109);
        label.font = [UIFont systemFontOfSize:14.5f];
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-35);
        }];
        _contentLabel = label;
    }
    return _contentLabel;
}

@end
