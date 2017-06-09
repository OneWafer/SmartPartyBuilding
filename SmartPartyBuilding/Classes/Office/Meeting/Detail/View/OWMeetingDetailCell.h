//
//  OWMeetingDetailCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/20.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OWMeetingDetailCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *detailDic;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
