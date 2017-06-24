//
//  OWPartyFeeDescCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/16.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OWPartyFeeDescCellBlock)();

@interface OWPartyFeeDescCell : UITableViewCell

@property (nonatomic, weak) UIButton *sltBtn;
@property (nonatomic, copy) OWPartyFeeDescCellBlock block;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
