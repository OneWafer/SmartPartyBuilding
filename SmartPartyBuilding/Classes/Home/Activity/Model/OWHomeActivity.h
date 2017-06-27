//
//  OWHomeActivity.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/27.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWHomeActivity : NSObject

/** id */
@property (nonatomic, assign) int id;
/** 管理员id */
@property (nonatomic, assign) int staffId;
/** 支部id */
@property (nonatomic, assign) int partyBranchId;
/** flag */
@property (nonatomic, assign) int flag;
/** 活动类型 */
@property (nonatomic, assign) int type;
/** 类型 */
@property (nonatomic, assign) int orderType;
/** 积分 */
@property (nonatomic, assign) int integral;
/** 点击数量 */
@property (nonatomic, assign) int clickAmount;
/** 是否最热 */
@property (nonatomic, assign) int isHot;
/** 是否最新 */
@property (nonatomic, assign) int isNew;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 开始时间 */
@property (nonatomic, copy) NSString *startTime;
/** 发布时间 */
@property (nonatomic, copy) NSString *publishTime;
/** 结束时间 */
@property (nonatomic, copy) NSString *endTime;
/** 活动详情 */
@property (nonatomic, copy) NSString *detail;
/** 图像 */
@property (nonatomic, copy) NSString *avatar;
/** 地址 */
@property (nonatomic, copy) NSString *address;
/** 支部名字 */
@property (nonatomic, copy) NSString *partyBranchName;
/** 结果 */
@property (nonatomic, copy) NSString *results;


///** 情况 */
//@property (nonatomic, assign) int situation;

@end


