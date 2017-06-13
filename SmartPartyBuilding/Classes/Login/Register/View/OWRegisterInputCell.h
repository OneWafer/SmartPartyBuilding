//
//  OWRegisterInputCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/11.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OWRegister;
typedef void(^OWRegisterVerBtnBlock)();

@interface OWRegisterInputCell : UITableViewCell

@property (nonatomic, strong) OWRegister *regist;
@property (nonatomic, copy) OWRegisterVerBtnBlock block;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
