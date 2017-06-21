//
//  OWLoginBranchVC.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OWBranch;
typedef void(^OWLoginBranchVCBlock)(OWBranch *branch);

@interface OWLoginBranchVC : UITableViewController

@property (nonatomic, copy) OWLoginBranchVCBlock block;
@property (nonatomic, strong) NSArray *branchList;

@end
