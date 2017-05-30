//
//  OWUserLineCellManager.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/19.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OWBaseUserLineCell;

@interface OWUserLineCellManager : NSObject

+ (instancetype) sharedInstance;

- (void) registerCell:(Class) itemClass cellClass:(Class ) cellClass;

- (OWBaseUserLineCell *) getCell:(Class) itemClass;

@end
