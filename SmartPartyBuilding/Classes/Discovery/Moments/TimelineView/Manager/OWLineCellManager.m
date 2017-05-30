//
//  OWLineCellManager.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/18.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWLineCellManager.h"
#import "OWTextImageLineItem.h"
#import "OWTextImageLineCell.h"
#import "OWVideoLineItem.h"
#import "OWVideoLineCell.h"

@interface OWLineCellManager ()

@property (strong, nonatomic) NSMutableDictionary *dic;

@end

@implementation OWLineCellManager

static OWLineCellManager  *_manager=nil;


#pragma mark - Lifecycle

+(instancetype) sharedInstance
{
    @synchronized(self){
        if (_manager == nil) {
            _manager = [[OWLineCellManager alloc] init];
        }
    }
    return _manager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _dic = [NSMutableDictionary dictionary];
        
        [self registerCell:[OWTextImageLineItem class] cellClass:[OWTextImageLineCell class]];
        [self registerCell:[OWVideoLineItem class] cellClass:[OWVideoLineCell class]];
        
    }
    return self;
}



#pragma mark - Method


-(void) registerCell:(Class) itemClass cellClass:(Class) cellClass
{
    [_dic setObject:[[cellClass alloc] init]  forKey:NSStringFromClass(itemClass)];
}


- (OWBaseLineCell *) getCell:(Class) itemClass
{
    return [_dic objectForKey:NSStringFromClass(itemClass)];
}


@end
