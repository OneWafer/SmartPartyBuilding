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
/** 车牌介绍 */
@property (nonatomic, copy) NSString *introduce;
/** 图片 */
@property (nonatomic, copy) NSString *imgs;
/** 车辆编号 */
@property (nonatomic, assign) int id;
/** 车辆所属支部id */
@property (nonatomic, assign) int partyBranchId;

@end
