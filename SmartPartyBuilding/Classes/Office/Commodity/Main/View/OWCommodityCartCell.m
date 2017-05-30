//
//  OWCommodityCartCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/23.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <UIImageView+WebCache.h>
#import "OWCommodityCartCell.h"

@interface OWCommodityCartCell ()

@property (nonatomic, weak) UIButton *sltBtn;
@property (nonatomic, weak) UIImageView *titleImgView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *remainLabel;
@property (nonatomic, weak) UIButton *addBtn;
@property (nonatomic, weak) UIButton *deleteBtn;
@property (nonatomic, weak) UITextField *numTF;
@property (nonatomic, weak) UIView *btmLineView;

@end

@implementation OWCommodityCartCell

static NSString *const identifier = @"OWCommodityCartCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWCommodityCartCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWCommodityCartCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        [self.sltBtn wh_addActionHandler:^(UIButton *sender) {
            
        }];
        
        [self.titleImgView sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1496635915&di=184dc5d94ebe166a437c412364e8818b&imgtype=jpg&er=1&src=http%3A%2F%2Fruanwenpic.b0.upaiyun.com%2Fueditor%2Fupyun%2F20170118%2F1484716972298812.png"] placeholderImage:wh_imageNamed(@"")];
        self.titleLabel.text = @"王老吉凉茶饮品310ml*24罐整箱 夏季茶饮料";
        self.remainLabel.text = @"剩余999瓶";
        
        [self.deleteBtn wh_addActionHandler:^(UIButton *sender) {
            
        }];
        
        self.numTF.text = @"1";
        
        [self.addBtn wh_addActionHandler:^(UIButton *sender) {
            
        }];
        
        self.btmLineView.backgroundColor = wh_lineColor;
    }
    return self;
}


#pragma mark - ---------- Lazy ----------

- (UIButton *)sltBtn
{
    if (!_sltBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:wh_imageNamed(@"office_cmd_radio") forState:UIControlStateNormal];
        [btn setBackgroundImage:wh_imageNamed(@"office_cmd_radio_slt") forState:UIControlStateSelected];
        [self.contentView addSubview:btn];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(15);
        }];
        _sltBtn = btn;
    }
    return _sltBtn;
}

- (UIImageView *)titleImgView
{
    if (!_titleImgView) {
        UIImageView *imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:imgView];
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.sltBtn.right).offset(15);
            make.centerY.equalTo(self);
            make.height.width.equalTo(self.height).multipliedBy(0.9);
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
        label.numberOfLines = 2;
        [self.contentView addSubview:label];
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleImgView.right).offset(15);
            make.top.equalTo(self).offset(10);
            make.width.equalTo(self).multipliedBy(0.5);
        }];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)remainLabel
{
    if (!_remainLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_RGB(169, 169, 169);
        label.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:label];
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel);
            make.centerY.equalTo(self).offset(5);
        }];
        _remainLabel = label;
    }
    return _remainLabel;
}

- (UIButton *)deleteBtn
{
    if (!_deleteBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:wh_imageNamed(@"office_cmd_minus") forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel);
            make.bottom.equalTo(self).offset(-10);
        }];
        _deleteBtn = btn;
    }
    return _deleteBtn;
}


- (UIButton *)addBtn
{
    if (!_addBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:wh_imageNamed(@"office_cmd_add") forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.numTF.right).offset(5);
            make.centerY.equalTo(self.deleteBtn);
        }];
        _addBtn = btn;
    }
    return _addBtn;
}


- (UITextField *)numTF
{
    if (!_numTF) {
        UITextField *tf = [[UITextField alloc] init];
        tf.textColor = wh_norFontColor;
        tf.font = [UIFont systemFontOfSize:12];
        tf.textAlignment = NSTextAlignmentCenter;
        tf.borderStyle = UITextBorderStyleRoundedRect;
        tf.keyboardType = UIKeyboardTypeNumberPad;
        [self.contentView addSubview:tf];
        [tf makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.deleteBtn);
            make.left.equalTo(self.titleLabel).offset(25);
            make.width.equalTo(35);
            make.height.equalTo(20);
        }];
        _numTF = tf;
    }
    return _numTF;
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
