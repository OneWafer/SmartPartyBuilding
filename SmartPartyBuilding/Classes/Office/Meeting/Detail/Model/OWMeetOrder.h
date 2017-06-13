//
//  OWMeetOrder.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/13.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWMeetOrder : NSObject

/** 会议室名称 */
@property (nonatomic, copy) NSString *name;
/** 会议内容 */
@property (nonatomic, copy) NSString *content;
/** 设施 */
@property (nonatomic, copy) NSString *facility;
/** 结束时间 */
@property (nonatomic, copy) NSString *endTime;
/** id */
@property (nonatomic, assign) int id;
/** 会议室id */
@property (nonatomic, assign) int roomId;
/**  */
@property (nonatomic, assign) NSInteger isAgree;
/**  */
@property (nonatomic, assign) int partyBranchId;
/** 参会人员 */
@property (nonatomic, copy) NSString *people;
/** 手机号 */
@property (nonatomic, copy) NSString *phoneNumber;
/** 备注信息 */
@property (nonatomic, copy) NSString *remark;
/** 回复 */
@property (nonatomic, copy) NSString *reply;
/** 管理人员id */
@property (nonatomic, assign) int staffId;
/** 管理人员 */
@property (nonatomic, copy) NSString *staffName;
/** 起始时间 */
@property (nonatomic, copy) NSString *startTime;

@end
