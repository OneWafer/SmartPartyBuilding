//
//  OWHomeMessage.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/7/5.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWHomeMessage : NSObject
/** id */
@property (nonatomic, assign) int id;
/** 用户id */
@property (nonatomic, assign) int userId;
/** 类型 */
@property (nonatomic, assign) int type;
/** 是否已读 */
@property (nonatomic, assign) int isRead;
/** 消息标题 */
@property (nonatomic, copy) NSString *title;
/** 消息内容 */
@property (nonatomic, copy) NSString *newsContent;
/** 创建时间 */
@property (nonatomic, copy) NSString *createTime;
/** 阅读时间 */
@property (nonatomic, copy) NSString *readTime;
/** 方法内容 */
@property (nonatomic, copy) NSString *functionContent;


@end
