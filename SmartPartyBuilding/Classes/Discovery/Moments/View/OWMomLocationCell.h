//
//  OWMomLocationCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/7/28.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AMapPOI;
@interface OWMomLocationCell : UITableViewCell

@property (nonatomic, strong) AMapPOI *poi;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
