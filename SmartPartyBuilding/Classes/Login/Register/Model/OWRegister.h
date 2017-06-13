//
//  OWRegister.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/12.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWRegister : NSObject

/** 图片 */
@property (nonatomic, copy) NSString *image;
/** 占位文字 */
@property (nonatomic, copy) NSString *place;
/** 内容 */
@property (nonatomic, copy) NSString *content;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 职务 */
@property (nonatomic, copy) NSString *duty;
/** 组织支部 */
@property (nonatomic, copy) NSString *organize;

@end
