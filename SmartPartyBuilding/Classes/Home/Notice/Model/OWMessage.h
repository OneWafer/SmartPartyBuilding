//
//  OWMessage.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/10.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWMessage : NSObject

/** id */
@property (nonatomic, assign) int id;
/** 是否已读 */
@property (nonatomic, assign) int isRead;
/** 通知id */
@property (nonatomic, assign) int messageId;
/** 读取时间 */
@property (nonatomic, copy) NSString *readTime;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 通知类型 */
@property (nonatomic, assign) int type;
/** 创建时间 */
@property (nonatomic, copy) NSString *createTime;
/** 用户id */
@property (nonatomic, assign) int userId;
/** 消息内容 */
@property (nonatomic, copy) NSString *newsContent;


@end
