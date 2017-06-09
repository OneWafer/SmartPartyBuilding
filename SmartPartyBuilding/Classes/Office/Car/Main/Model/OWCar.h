//
//  OWCar.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/31.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWCar : NSObject

/** 车牌号 */
@property (nonatomic, copy) NSString *carNum;
/** 排量 */
@property (nonatomic, copy) NSString *capacity;
/** 座位数 */
@property (nonatomic, copy) NSString *displacement;
/** 司机 */
@property (nonatomic, copy) NSString *driver;
/** 车牌介绍 */
@property (nonatomic, copy) NSString *introduce;
/**  */
@property (nonatomic, copy) NSString *model;
/**  */
@property (nonatomic, copy) NSString *name;
/** 联系电话 */
@property (nonatomic, copy) NSString *imgs;
/** 图片 */
@property (nonatomic, copy) NSString *phone;
/** 车辆编号 */
@property (nonatomic, assign) int id;
/** 车辆所属支部id */
@property (nonatomic, assign) int partyBranchId;

@end
