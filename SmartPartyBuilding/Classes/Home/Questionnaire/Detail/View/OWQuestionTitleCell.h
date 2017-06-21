//
//  OWQuestionTitleCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OWQuestion;
@interface OWQuestionTitleCell : UITableViewCell

@property (nonatomic, strong) OWQuestion *question;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
