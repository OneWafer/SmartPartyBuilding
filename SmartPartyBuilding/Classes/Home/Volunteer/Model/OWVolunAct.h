//
//  OWVolunAct.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/25.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWVolunAct : NSObject

/** id */
@property (nonatomic, assign) int id;
/** 支部id */
@property (nonatomic, assign) int partyBranchId;
/** 管理员id */
@property (nonatomic, assign) int staffId;
/** 活动标题 */
@property (nonatomic, copy) NSString *title;
/** 支部名字 */
@property (nonatomic, copy) NSString *partyBranchName;
/** 活动详情 */
@property (nonatomic, copy) NSString *detail;
/** 头像 */
@property (nonatomic, copy) NSString *avatar;
/** 地址 */
@property (nonatomic, copy) NSString *address;
/** 开始时间 */
@property (nonatomic, copy) NSString *startTime;
/** 结束时间 */
@property (nonatomic, copy) NSString *endTime;
/** 发布时间 */
@property (nonatomic, copy) NSString *publishTime;
/** 是否最新 */
@property (nonatomic, assign) int isNew;
/** 是否最热 */
@property (nonatomic, assign) int isHot;
/** 积分 */
@property (nonatomic, assign) int integral;
/** 点击量 */
@property (nonatomic, assign) int clickAmount;



@end
