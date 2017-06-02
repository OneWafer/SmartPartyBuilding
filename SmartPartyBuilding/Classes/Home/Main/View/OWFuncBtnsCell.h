//
//  OWFuncBtnsCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/14.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OWFuncBtnsBlock)(NSInteger tag);

@interface OWFuncBtnsCell : UITableViewCell

@property (nonatomic, strong) NSArray *titleList;

@property (nonatomic, copy) OWFuncBtnsBlock funcBtnBlock;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
