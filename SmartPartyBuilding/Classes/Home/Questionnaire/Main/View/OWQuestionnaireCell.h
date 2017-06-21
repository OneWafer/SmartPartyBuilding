//
//  OWQuestionnaireCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OWQuestionnaire;
@interface OWQuestionnaireCell : UITableViewCell

@property (nonatomic, strong) OWQuestionnaire *questionnaire;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
