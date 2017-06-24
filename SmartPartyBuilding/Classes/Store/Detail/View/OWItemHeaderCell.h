//
//  OWItemHeaderCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/21.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OWStoreItem;
typedef void(^OWItemHeaderCellBlock)();

@interface OWItemHeaderCell : UITableViewCell

@property (nonatomic, strong) OWStoreItem *item;
@property (nonatomic, copy) OWItemHeaderCellBlock block;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
