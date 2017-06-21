//
//  OWLoginBranchCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OWLoginBranchCell : UITableViewCell

@property (nonatomic, copy) NSString *title;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
