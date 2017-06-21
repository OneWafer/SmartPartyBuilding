//
//  OWQuestionSubmitCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/18.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OWQuestionSubmitCellBlock)();

@interface OWQuestionSubmitCell : UITableViewCell

@property (nonatomic, copy) OWQuestionSubmitCellBlock block;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
