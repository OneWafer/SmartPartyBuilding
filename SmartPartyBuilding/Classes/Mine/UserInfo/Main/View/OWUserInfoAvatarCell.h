//
//  OWUserInfoAvatarCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/16.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OWUserInfoAvatarCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *optionDic;
@property (nonatomic, weak) UIImageView *avatarImgView;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
