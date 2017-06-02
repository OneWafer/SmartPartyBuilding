//
//  OWHomeTitleCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/15.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWHomeTitleCell.h"

@interface OWHomeTitleCell ()

@property (nonatomic, weak) UIImageView *bgImgView;
@property (nonatomic, weak) UIImageView *titleImgView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *moreBtn;

@end

@implementation OWHomeTitleCell

static NSString *const identifier = @"OWHomeTitleCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWHomeTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWHomeTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        self.bgImgView.image = wh_imageNamed(@"home_title");
    }
    return self;
}

- (void)setTitleDic:(NSDictionary *)titleDic
{
    _titleDic = titleDic;
    self.titleImgView.image = wh_imageNamed(titleDic[@"image"]);
    self.titleLabel.text = titleDic[@"title"];
    wh_weakSelf(self);
    if ([self.titleLabel.text isEqualToString:@"党建要闻"]) {
        [self.moreBtn wh_addActionHandler:^(UIButton *sender) {
            wh_Log(@"点击了更多按钮");
        }];
    }
}


#pragma mark - ---------- Lazy ----------

- (UIImageView *)bgImgView
{
    if (!_bgImgView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        _bgImgView = imgView;
    }
    return _bgImgView;
}


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
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:15.0f];
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.titleImgView.right).offset(10);
        }];
        _titleLabel = label;
    }
    return _titleLabel;
}


- (UIButton *)moreBtn
{
    if (!_moreBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"更多" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setImage:wh_imageNamed(@"home_arrow_white") forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12.0f];
        [btn wh_setImagePosition:WHImagePositionRight spacing:0];
        [self.contentView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-15);
        }];
        _moreBtn = btn;
    }
    return _moreBtn;
}

@end
