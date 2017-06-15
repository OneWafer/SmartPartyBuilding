//
//  OWDisInputViewCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/15.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OWDisInput;
@interface OWDisInputViewCell : UITableViewCell

@property (nonatomic, strong) OWDisInput *input;
@property (nonatomic, weak) UITextView *inputView;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
