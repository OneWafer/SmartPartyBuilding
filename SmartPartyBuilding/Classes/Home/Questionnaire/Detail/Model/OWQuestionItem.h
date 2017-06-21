//
//  OWQuestionItem.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWQuestionItem : NSObject

/** 选项id */
@property (nonatomic, assign) int id;
/** 问题id */
@property (nonatomic, assign) int questionId;
/** 选项排序 */
@property (nonatomic, assign) int optionNum;
/** 是否是正确答案 */
@property (nonatomic, assign) int isCorrect;
/** 选项内容 */
@property (nonatomic, copy) NSString *optionContent;

@end
