//
//  OWCarOrder.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/8.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWCarOrder : NSObject

/** 随车用品 */
@property (nonatomic, copy) NSString *articles;
/** 车牌id */
@property (nonatomic, copy) NSString *carId;
/** 车牌号 */
@property (nonatomic, copy) NSString *carNum;
/** 结束时间 */
@property (nonatomic, copy) NSString *endTime;
/** id */
@property (nonatomic, assign) int id;
/**  */
@property (nonatomic, assign) BOOL isAgree;
/**  */
@property (nonatomic, assign) int partyBranchId;
/** 随车人员 */
@property (nonatomic, copy) NSString *people;
/** 手机号 */
@property (nonatomic, copy) NSString *phoneNumber;
/** 车辆用途 */
@property (nonatomic, copy) NSString *purpose;
/** 备注信息 */
@property (nonatomic, copy) NSString *remark;
/** 答复 */
@property (nonatomic, copy) NSString *reply;
/** 管理人员id */
@property (nonatomic, assign) int staffId;
/** 管理人员 */
@property (nonatomic, copy) NSString *staffName;
/** 起始时间 */
@property (nonatomic, copy) NSString *startTime;

@end
