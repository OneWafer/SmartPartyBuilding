//
//  OWRegisterInputCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/11.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OWRegisterInputCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *titleDic;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
