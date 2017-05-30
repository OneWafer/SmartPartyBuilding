//
//  OWFaceManager.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWFaceManager.h"

@interface OWFaceManager ()

@property (strong, nonatomic) NSMutableArray *emotions;

@property (strong, nonatomic) MLExpression *expression;

@end

@implementation OWFaceManager

static  OWFaceManager *_manager=nil;


#pragma mark - Lifecycle

+(instancetype) sharedInstance
{
    @synchronized(self){
        if (_manager == nil) {
            _manager = [[OWFaceManager alloc] init];
        }
    }
    return _manager;
}




- (instancetype)init
{
    self = [super init];
    if (self) {
        _emotions = [NSMutableArray array];
    }
    return self;
}





#pragma mark - Method


-(MLExpression *)sharedMLExpression
{
    if (_expression == nil) {
        _expression = [MLExpression expressionWithRegex:@"\\[[a-zA-Z0-9\\u4e00-\\u9fa5]+\\]" plistName:@"Expression" bundleName:@"ClippedExpression"];
    }
    
    return _expression;
}

@end
