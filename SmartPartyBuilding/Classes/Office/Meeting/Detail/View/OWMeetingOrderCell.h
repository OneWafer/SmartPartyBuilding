//
//  OWMeetingOrderCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/20.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OWCarOrder;
@class OWMeetOrder;
@interface OWMeetingOrderCell : UITableViewCell

@property (nonatomic, strong) OWCarOrder *carOrder;
@property (nonatomic, strong) OWMeetOrder *meetOrder;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
