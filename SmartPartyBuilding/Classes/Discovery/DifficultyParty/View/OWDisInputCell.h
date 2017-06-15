//
//  OWDisInputCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/15.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OWDisInput;
@interface OWDisInputCell : UITableViewCell

@property (nonatomic, strong) OWDisInput *input;
@property (nonatomic, weak) UITextField *inputTF;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
