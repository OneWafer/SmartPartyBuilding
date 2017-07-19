//
//  OWHomeConsultation.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/7/16.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWHomeConsultation : NSObject

/** id */
@property (nonatomic, assign) int id;
/** 用户id */
@property (nonatomic, assign) int userId;
/** 管理回复 */
@property (nonatomic, assign) int adminReply;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 图像 */
@property (nonatomic, copy) NSString *avatar;
/** 用户名 */
@property (nonatomic, copy) NSString *staffName;
/** 创建时间 */
@property (nonatomic, copy) NSString *createTime;
/** url */
@property (nonatomic, copy) NSString *url;

@end
