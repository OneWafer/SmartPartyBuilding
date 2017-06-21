//
//  OWQuestionTitleCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWQuestionTitleCell.h"
#import "OWQuestion.h"

@interface OWQuestionTitleCell ()

@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation OWQuestionTitleCell

static NSString *const identifier = @"OWQuestionTitleCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWQuestionTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWQuestionTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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


- (void)setQuestion:(OWQuestion *)question
{
    _question = question;
//    self.titleLabel.text = [NSString stringWithFormat:@"%d. %@ %@",question.questionId, question.questionContent, (question.questionType == 2) ? @"(多选)" : @""];
    self.titleLabel.text = [NSString stringWithFormat:@"%d. %@",question.questionId, question.questionContent];
}

#pragma mark - ---------- Lazy ----------

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:15.0f];
        label.textColor = wh_norFontColor;
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self).offset(15);
        }];
        _titleLabel = label;
    }
    return _titleLabel;
}

@end
