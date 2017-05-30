//
//  OWBaseUserLineItem.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/19.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWBaseUserLineItem : NSObject

@property (nonatomic, assign) long long itemId;

@property (nonatomic, assign) long long ts;

@property (nonatomic, assign) NSUInteger year;

@property (nonatomic, assign) NSUInteger month;

@property (nonatomic, assign) NSUInteger day;

@property (nonatomic, assign) BOOL bShowTime;

@end
