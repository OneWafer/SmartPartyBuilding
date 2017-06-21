//
//  OWRegisterPickerCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/12.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OWRegisterPickerBlock)(NSInteger tag);

@interface OWRegisterPickerCell : UITableViewCell

@property (nonatomic, copy) OWRegisterPickerBlock block;
@property (nonatomic, weak) UIButton *sexBtn;
@property (nonatomic, weak) UIButton *organizeBtn;
@property (nonatomic, weak) UIButton *dutyBtn;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
