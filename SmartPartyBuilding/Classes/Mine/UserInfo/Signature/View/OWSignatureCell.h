//
//  OWSignatureCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/27.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OWSignatureCell : UITableViewCell

@property (nonatomic, weak) UITextView *inputView;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
