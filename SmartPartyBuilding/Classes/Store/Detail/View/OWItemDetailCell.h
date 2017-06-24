//
//  OWItemDetailCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/23.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OWStoreItem;
@interface OWItemDetailCell : UITableViewCell

@property (nonatomic, strong) OWStoreItem *item;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
