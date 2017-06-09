//
//  OWMeeting.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/10.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWMeeting : NSObject

/** id */
@property (nonatomic, assign) int id;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 容纳人数 */
@property (nonatomic, assign) int capacity;
/** 图片 */
@property (nonatomic, copy) NSString *imgs;
/** 介绍 */
@property (nonatomic, copy) NSString *introduce;
/** 地址 */
@property (nonatomic, copy) NSString *location;
/** 管理员 */
@property (nonatomic, copy) NSString *manager;
/** 所属支部id */
@property (nonatomic, assign) int partyBranchId;
/** 联系电话 */
@property (nonatomic, copy) NSString *phone;

@end
