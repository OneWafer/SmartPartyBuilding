//
//  OWMtOrderDateCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/5.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OWDateCellBlock)(NSInteger tag);

@interface OWMtOrderDateCell : UITableViewCell

@property (nonatomic, copy) OWDateCellBlock block;

@property (nonatomic, weak) UILabel *startLabel;
@property (nonatomic, weak) UILabel *endLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
