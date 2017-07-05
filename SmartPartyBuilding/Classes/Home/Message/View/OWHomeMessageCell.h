//
//  OWHomeMessageCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/7/5.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OWHomeMessage;
@interface OWHomeMessageCell : UITableViewCell

@property (nonatomic, strong) OWHomeMessage *message;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
