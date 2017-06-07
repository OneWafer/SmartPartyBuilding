//
//  OWHomeNewsCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/4.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OWNews;
@interface OWHomeNewsCell : UITableViewCell

@property (nonatomic, strong) OWNews *news;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
