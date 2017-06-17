//
//  OWExcPartyMember.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/16.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWExcPartyMember : NSObject

/** id */
@property (nonatomic, assign) int id;
/** 用户id */
@property (nonatomic, assign) int userId;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 头像 */
@property (nonatomic, copy) NSString *avatar;
/** 点击量 */
@property (nonatomic, assign) int clickAmount;
/** 评选时间 */
@property (nonatomic, copy) NSString *selectionDate;
/** 先进事迹 */
@property (nonatomic, copy) NSString *meritoriousDeeds;


@end
