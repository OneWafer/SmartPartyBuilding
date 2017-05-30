//
//  OWMeetingDateCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/20.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWMeetingDateCell.h"

@interface OWMeetingDateCell ()

@property (nonatomic, weak) UILabel *dateLabel;

@end

@implementation OWMeetingDateCell

static NSString *const identifier = @"OWMeetingDateCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWMeetingDateCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWMeetingDateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.dateLabel.text = title;
}

#pragma mark - ---------- Lazy ----------
- (UILabel *)dateLabel
{
    if (!_dateLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_RGB(217, 17, 22);
        label.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(15);
        }];
        _dateLabel = label;
    }
    return _dateLabel;
}

@end
