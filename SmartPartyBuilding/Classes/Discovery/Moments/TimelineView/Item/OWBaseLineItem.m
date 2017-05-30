//
//  OWBaseLineItem.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWBaseLineItem.h"

@implementation OWBaseLineItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _likes = [NSMutableArray array];
        _comments = [NSMutableArray array];
        
        _commentStrArray = [NSMutableArray array];
    }
    return self;
}

@end
