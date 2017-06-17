//
//  OWEPMSearchResultVC.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/16.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OWEPMSearchResultVC : UITableViewController

@property (nonatomic, strong) NSArray *resultList;
//在MySearchResultViewController添加一个指向展示页的【弱】引用属性。
@property (nonatomic, weak) UIViewController *mainSearchController;

@end
