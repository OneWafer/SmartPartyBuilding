//
//  OWUserLineCellManager.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/19.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWUserLineCellManager.h"
#import "OWBaseUserLineCell.h"
#import "OWTextImageUserLineItem.h"
#import "OWTextImageUserLineCell.h"

@interface OWUserLineCellManager ()

@property (nonatomic, strong) NSMutableDictionary *dic;

@end

@implementation OWUserLineCellManager

static OWUserLineCellManager  *_manager=nil;


#pragma mark - Lifecycle

+(instancetype) sharedInstance
{
    @synchronized(self){
        if (_manager == nil) {
            _manager = [[OWUserLineCellManager alloc] init];
        }
    }
    return _manager;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _dic = [NSMutableDictionary dictionary];
        
        [self registerCell:[OWTextImageUserLineItem class] cellClass:[OWTextImageUserLineCell class]];
    }
    return self;
}



#pragma mark - Method


-(void) registerCell:(Class) itemClass cellClass:(Class) cellClass
{
    [_dic setObject:[[cellClass alloc] init]  forKey:NSStringFromClass(itemClass)];
}


-(OWBaseUserLineCell *) getCell:(Class) itemClass
{
    return [_dic objectForKey:NSStringFromClass(itemClass)];
}

@end
