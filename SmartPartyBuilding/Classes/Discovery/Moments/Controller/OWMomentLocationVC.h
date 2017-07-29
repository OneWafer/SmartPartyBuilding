//
//  OWMomentLocationVC.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/7/27.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AMapPOI;
typedef void(^OWMomentLocationVCBlock)(AMapPOI *poi);
@interface OWMomentLocationVC : UITableViewController

@property (nonatomic, copy) OWMomentLocationVCBlock block;

@end
