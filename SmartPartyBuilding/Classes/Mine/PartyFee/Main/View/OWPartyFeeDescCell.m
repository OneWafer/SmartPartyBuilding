//
//  OWPartyFeeDescCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/16.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWPartyFeeDescCell.h"
//#import "OWEdgeLabel.h"

@interface OWPartyFeeDescCell ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *descLabel;
@property (nonatomic, weak) UIButton *sltBtn;
@property (nonatomic, weak) UIView *lineView;

@end

@implementation OWPartyFeeDescCell

static NSString *const identifier = @"OWPartyFeeDescCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWPartyFeeDescCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWPartyFeeDescCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        self.titleLabel.text = @"缴费注释";
        self.descLabel.text = @"如果您是开发区支部党员，目前党内职务为干事，月缴党费为50.0元。可以在下列表选择党费缴纳月份，目前系统支持最大6个月，最小1个月。您一次多缴纳数月，则在后续党费费缴纳过程中不会受到系统推送消息和短消息，在您多缴纳月份扣除结束后，您将在最后一次需缴纳前收到短信及app内消息。祝您生活愉快，党感谢您对革命事业的支持!";
//        self.descLabel.text = @"如果您是开发区支部党员，目前党内职务为干事，月缴党费为50.0元。可以在下列表选择党费缴纳月份";
        [self.sltBtn wh_addActionHandler:^(UIButton *sender) {
            wh_Log(@"----点击了学分选择");
        }];
        self.lineView.backgroundColor = wh_lineColor;
    }
    return self;
}


#pragma mark - ---------- Lazy ----------

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_norFontColor;
        label.font = [UIFont systemFontOfSize:15.5f];
        [self.contentView addSubview:label];
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self).offset(10);
        }];
        _titleLabel = label;
    }
    return _titleLabel;
}

- (UILabel *)descLabel
{
    if (!_descLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:13.5f];
        label.textColor = wh_RGB(109, 109, 109);
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(25);
            make.right.equalTo(self).offset(-25);
            make.top.equalTo(self.titleLabel.bottom).offset(10);
        }];
        _descLabel = label;
    }
    return _descLabel;
}

- (UIButton *)sltBtn
{
    if (!_sltBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitle:@"请选择缴费月数" forState:UIControlStateNormal];
        [btn setTitleColor:wh_norFontColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.5f];
        [btn setImage:wh_imageNamed(@"office_down") forState:UIControlStateNormal];
        [btn wh_setImagePosition:WHImagePositionRight spacing:5];
        [self.contentView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self).offset(-25);
            make.width.equalTo(self).multipliedBy(0.75);
            make.height.equalTo(40);
        }];
        
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = wh_lineColor.CGColor;
        _sltBtn = btn;
    }
    return _sltBtn;
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
