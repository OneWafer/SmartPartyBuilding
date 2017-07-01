//
//  OWHomeHeadlineCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/4.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OWHomeHeadlineCellBlock)(NSInteger tag);

@interface OWHomeHeadlineCell : UITableViewCell

@property (nonatomic, strong) NSArray *newsList;
@property (nonatomic, copy) OWHomeHeadlineCellBlock block;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
