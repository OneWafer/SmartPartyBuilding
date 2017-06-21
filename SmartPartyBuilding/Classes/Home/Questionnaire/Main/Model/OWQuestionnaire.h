//
//  OWQuestionnaire.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWQuestionnaire : NSObject

/** id */
@property (nonatomic, assign) int id;
/** 是否打开 */
@property (nonatomic, assign) int isOpen;
/** 创建者id */
@property (nonatomic, assign) int createUserId;
/** 创建时间 */
@property (nonatomic, copy) NSString *createTime;
/** 问卷名字 */
@property (nonatomic, copy) NSString *researchName;
/** 问卷目标 */
@property (nonatomic, copy) NSString *researchGoal;
/** 开始时间 */
@property (nonatomic, copy) NSString *startTime;
/** 结束时间 */
@property (nonatomic, copy) NSString *stopTime;

@end
