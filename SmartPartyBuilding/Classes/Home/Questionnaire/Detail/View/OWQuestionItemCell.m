//
//  OWQuestionItemCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWQuestionItemCell.h"
#import "OWQuestionItem.h"

@interface OWQuestionItemCell ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIView *btmLineView;

@end

@implementation OWQuestionItemCell

static NSString *const identifier = @"OWQuestionItemCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWQuestionItemCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWQuestionItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        self.sltImgView.image = wh_imageNamed(@"office_cmd_radio");
    }
    return self;
}


- (void)setItem:(OWQuestionItem *)item
{
    _item = item;
    self.titleLabel.text = item.optionContent;
}

#pragma mark - ---------- Lazy ----------

- (UIImageView *)sltImgView
{
    if (!_sltImgView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(15);
        }];
        _sltImgView = imgView;
    }
    return _sltImgView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14.5f];
        label.textColor = wh_RGB(0, 178, 236);
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.sltImgView.right).offset(10);
        }];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UIView *)btmLineView
{
    if (!_btmLineView) {
        UIView *view = [[UIView alloc] init];
        [self.contentView addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self);
            make.height.equalTo(0.5);
        }];
        _btmLineView = view;
    }
    return _btmLineView;
}


@end
