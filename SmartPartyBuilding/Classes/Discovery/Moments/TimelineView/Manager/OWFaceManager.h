//
//  OWFaceManager.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <MLExpressionManager.h>
#import <Foundation/Foundation.h>

@interface OWFaceManager : NSObject

+(instancetype) sharedInstance;

-(MLExpression *) sharedMLExpression;

@end
