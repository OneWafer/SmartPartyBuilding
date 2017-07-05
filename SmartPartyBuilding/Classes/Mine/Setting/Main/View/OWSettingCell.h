//
//  OWSettingCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/16.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OWSettingCell : UITableViewCell

@property (nonatomic, copy) NSDictionary *titleDic;
@property (nonatomic, weak) UILabel *contentLabel;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
