//
//  OWHomeHeadlineCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/4.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OWHomeHeadlineCell : UITableViewCell

@property (nonatomic, strong) NSArray *newsList;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
