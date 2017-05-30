//
//  OWMineOptionCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/15.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OWMineOptionCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *optionDic;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
