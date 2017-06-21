//
//  OWItemTitleCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/21.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWItemTitleCell.h"

@interface OWItemTitleCell ()

@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation OWItemTitleCell

static NSString *const identifier = @"OWItemTitleCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWItemTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWItemTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        self.titleLabel.text = @"华润怡宝，中国饮用水市场的领先品牌，在华南地区市场占有率连续多年稳居首位，2007年销量达到108万吨。1989年，华润怡宝在国内率先推出纯净水，是国内最早专业化生产包装水的企业之一。";
    }
    return self;
}

#pragma mark - ---------- Lazy ----------

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14.0f];
        label.textColor = wh_norFontColor;
        label.numberOfLines = 0;
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.equalTo(self).multipliedBy(0.9);
            
        }];
        _titleLabel = label;
    }
    return _titleLabel;
}

@end
