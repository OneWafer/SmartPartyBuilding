//
//  OWCommodityFallCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/29.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OWCommodityFallCellBlock)();

@interface OWCommodityFallCell : UITableViewCell

@property (nonatomic, copy) OWCommodityFallCellBlock block;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
