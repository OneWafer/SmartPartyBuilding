//
//  OWMineCollection.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/27.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWMineCollection : NSObject

/** id */
@property (nonatomic, assign) int id;
/** 收藏对象id */
@property (nonatomic, assign) int markedId;
/** 管理员id */
@property (nonatomic, assign) int staffId;
/** 对象类型 */
@property (nonatomic, assign) int type;
/** 收藏对象标题 */
@property (nonatomic, copy) NSString *title;
/** 收藏时间 */
@property (nonatomic, copy) NSString *markedTime;
/** 收藏对象图片 */
@property (nonatomic, copy) NSString *cover;



@end
