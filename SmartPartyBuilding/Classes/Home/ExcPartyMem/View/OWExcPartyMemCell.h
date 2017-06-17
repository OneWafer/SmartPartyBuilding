//
//  OWExcPartyMemCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/16.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OWExcPartyMember;
@interface OWExcPartyMemCell : UITableViewCell

@property (nonatomic, strong) OWExcPartyMember *member;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
