//
//  OWMeetingDetailCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/20.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWMeetingDetailCell.h"

@interface OWMeetingDetailCell ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *contentLabel;
@property (nonatomic, weak) UIButton *telBtn;

@end

@implementation OWMeetingDetailCell

static NSString *const identifier = @"OWMeetingDetailCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWMeetingDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWMeetingDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        
    }
    return self;
}


- (void)setDetailDic:(NSDictionary *)detailDic
{
    _detailDic = detailDic;
    self.titleLabel.text = detailDic[@"title"];
    if ([detailDic[@"title"] isEqualToString:@"联系电话 :"]) {
        [self.telBtn setTitle:detailDic[@"content"] forState:UIControlStateNormal];
        [self.telBtn wh_addActionHandler:^(UIButton *sender) {
            wh_Log(@"-----");
        }];
    }else{
        self.contentLabel.text = detailDic[@"content"];
    }
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
        label.textColor = wh_norFontColor;
        label.font = [UIFont systemFontOfSize:14.5f];
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.titleLabel.right).offset(10);
        }];
        _contentLabel = label;
    }
    return _contentLabel;
}

- (UIButton *)telBtn
{
    if (!_telBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitleColor:wh_RGB(9, 131, 216) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.5f];
        [self.contentView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.titleLabel.right).offset(10);
        }];
        _telBtn = btn;
    }
    return _telBtn;
}

@end
