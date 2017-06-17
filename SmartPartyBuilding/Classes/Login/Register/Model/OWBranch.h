//
//  OWBranch.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/16.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWBranch : NSObject

/** id */
@property (nonatomic, assign) int id;
/** 上级支部id */
@property (nonatomic, assign) int fatherId;
/** 单位id */
@property (nonatomic, assign) int enterpriseId;
/** 支部名称 */
@property (nonatomic, copy) NSString *organizationName;
/** 支部code */
@property (nonatomic, copy) NSString *organizationCode;
/** 支部类型 */
@property (nonatomic, copy) NSString *organizationType;
/** 电话 */
@property (nonatomic, copy) NSString *phoneNumber;
/** 邮编 */
@property (nonatomic, copy) NSString *postalCode;
/** 地址 */
@property (nonatomic, copy) NSString *address;
/** 成立日期 */
@property (nonatomic, copy) NSString *setupDate;
/** 备注 */
@property (nonatomic, copy) NSString *remark;
/** 关系 */
@property (nonatomic, copy) NSString *relationship;
/** 经度 */
@property (nonatomic, copy) NSString *longitude;
/** 纬度 */
@property (nonatomic, copy) NSString *latitude;


@end
