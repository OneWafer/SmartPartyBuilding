//
//  OWMineThumbup.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/27.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWMineThumbup : NSObject

/** id */
@property (nonatomic, assign) int id;
/** 点赞对象id */
@property (nonatomic, assign) int praisedId;
/** 管理员id */
@property (nonatomic, assign) int staffId;
/** 对象类型 */
@property (nonatomic, assign) int type;
/** 被点赞对象标题 */
@property (nonatomic, copy) NSString *title;
/** 点赞时间 */
@property (nonatomic, copy) NSString *praisedTime;
/** 被点赞对象图片 */
@property (nonatomic, copy) NSString *cover;



@end
