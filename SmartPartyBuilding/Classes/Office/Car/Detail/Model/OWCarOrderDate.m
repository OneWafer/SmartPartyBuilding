//
//  OWCarOrderDate.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/12.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <MJExtension.h>
#import "OWCarOrderDate.h"
#import "OWCarOrder.h"

@implementation OWCarOrderDate

+(NSDictionary *)mj_objectClassInArray
{
    return @{
             @"orders" : @"OWCarOrder"
             };
}


@end
