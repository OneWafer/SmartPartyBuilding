//
//  OWQuestion.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWQuestion : NSObject

/** id */
@property (nonatomic, assign) int id;
/** 问卷id */
@property (nonatomic, assign) int researchId;
/** 问题id */
@property (nonatomic, assign) int questionId;
/** 问题排序 */
@property (nonatomic, assign) int questionSort;
/** 问题类型(1单选2多选) */
@property (nonatomic, assign) int questionType;
/** 问题分值 */
@property (nonatomic, assign) int questionScore;
/** 题干 */
@property (nonatomic, copy) NSString *questionContent;
/** 解析 */
@property (nonatomic, copy) NSString *explains;
/** 用户答案 */
@property (nonatomic, copy) NSString *userAnswer;
/** 选项数组 */
@property (nonatomic, strong) NSArray *items;
/** 选中的答案 */
@property (nonatomic, copy) NSIndexPath *idx;

@end
