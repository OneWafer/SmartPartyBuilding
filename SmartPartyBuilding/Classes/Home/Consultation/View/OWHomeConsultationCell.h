//
//  OWHomeConsultationCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/7/16.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OWHomeConsultation;
@interface OWHomeConsultationCell : UITableViewCell

@property (nonatomic, strong) OWHomeConsultation *consultation;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
