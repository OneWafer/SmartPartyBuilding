//
//  OWModuleCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/19.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OWModuleCellBlock)(NSInteger tag);

@interface OWModuleCell : UITableViewCell

@property (nonatomic, copy) OWModuleCellBlock block;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
