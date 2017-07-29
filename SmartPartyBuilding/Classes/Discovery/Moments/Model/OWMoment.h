//
//  OWMoment.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/7/22.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWMoment : NSObject

/** id */
@property (nonatomic, assign) int id;
/** 用户id */
@property (nonatomic, assign) int userId;
/** 用户姓名 */
@property (nonatomic, copy) NSString *staffName;
/** 用户头像 */
@property (nonatomic, copy) NSString *avatar;
/** 内容 */
@property (nonatomic, copy) NSString *title;
/** 发布时间 */
@property (nonatomic, copy) NSString *createTime;
/** 地址信息 */
@property (nonatomic, copy) NSString *addressInfo;
/** 图片地址(,号分隔) */
@property (nonatomic, copy) NSString *url;
/** 管理员发布的专业回复（只有互动咨询2才有） */
@property (nonatomic, copy) NSString *adminReply;


@end
