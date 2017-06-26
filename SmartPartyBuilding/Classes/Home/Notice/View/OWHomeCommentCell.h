//
//  OWHomeCommentCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/26.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OWMsgComment;
@interface OWHomeCommentCell : UITableViewCell

@property (nonatomic, strong) OWMsgComment *comment;
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
