//
//  OWQuestionItemCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OWQuestionItem;
@interface OWQuestionItemCell : UITableViewCell

@property (nonatomic, strong) OWQuestionItem *item;
@property (nonatomic, weak) UIImageView *sltImgView;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
