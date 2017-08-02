//
//  OWTextImageLineItem.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWTextImageLineItem.h"

@implementation OWTextImageLineItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _text = @"";
        _thumbImages = [NSArray array];
        _thumbPreviewImages = [NSArray array];
        _srcImages = [NSArray array];
    }
    return self;
}
@end
