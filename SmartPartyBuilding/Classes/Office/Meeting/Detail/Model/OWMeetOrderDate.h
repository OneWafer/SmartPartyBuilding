//
//  OWMeetOrderDate.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/13.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWMeetOrderDate : NSObject

/** 日期 */
@property (nonatomic, copy) NSString *date;
/** 预约列表 */
@property (nonatomic, strong) NSArray *orders;

@end
