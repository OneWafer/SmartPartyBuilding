//
//  OWMineThumbupCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/27.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OWMineThumbup;
@interface OWMineThumbupCell : UITableViewCell

@property (nonatomic, strong) OWMineThumbup *thumbup;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
