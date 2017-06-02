//
//  OWMettingManagerCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/20.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OWCar;
@interface OWMettingManagerCell : UITableViewCell

@property (nonatomic, strong) OWCar *car;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
