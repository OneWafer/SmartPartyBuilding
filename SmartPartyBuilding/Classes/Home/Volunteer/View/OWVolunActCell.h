//
//  OWVolunActCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/25.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OWVolunAct;
@interface OWVolunActCell : UITableViewCell

@property (nonatomic, strong) OWVolunAct *act;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
