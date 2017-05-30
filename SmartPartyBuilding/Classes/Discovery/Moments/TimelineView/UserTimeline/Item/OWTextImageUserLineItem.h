//
//  OWTextImageUserLineItem.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/19.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWBaseUserLineItem.h"

@interface OWTextImageUserLineItem : OWBaseUserLineItem

@property (nonatomic, strong) NSString *cover;

@property (nonatomic, strong) NSString *text;

@property (nonatomic, assign) NSUInteger photoCount;

@end
