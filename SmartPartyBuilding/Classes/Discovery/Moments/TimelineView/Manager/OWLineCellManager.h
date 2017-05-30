//
//  OWLineCellManager.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/18.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OWBaseLineCell;

@interface OWLineCellManager : NSObject

+(instancetype) sharedInstance;

-(void) registerCell:(Class) itemClass cellClass:(Class ) cellClass;

-(OWBaseLineCell *) getCell:(Class) itemClass;

@end
