//
//  OWStoreItem.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/22.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWStoreItem : NSObject

/** 类型 */
@property (nonatomic, assign) int belong; // 1党员回馈, 2员工物品
/** id */
@property (nonatomic, assign) int id;
/** 积分 */
@property (nonatomic, assign) int integral;
/** 数量 */
@property (nonatomic, assign) int num;
/** 名字 */
@property (nonatomic, copy) NSString *itemName;
/** 图片 */
@property (nonatomic, copy) NSString *avatar;
/** 简介 */
@property (nonatomic, copy) NSString *introduce;



@end
