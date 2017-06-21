//
//  OWOrderDetailPriceCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/21.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OWOrderDetailPriceCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *priceDic;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
