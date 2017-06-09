//
//  OWNews.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/7.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWNews : NSObject

/** id */
@property (nonatomic, assign) int id;
/** 标题 */
@property (nonatomic, copy) NSString *title;
/** 短标题 */
@property (nonatomic, copy) NSString *subtitle;
/** 备注 */
@property (nonatomic, copy) NSString *remark;
/** 栏目id */
@property (nonatomic, assign) int programaId;
/** 专题id */
@property (nonatomic, assign) int specialId;
/** 创建时间 */
@property (nonatomic, copy) NSString *createTime;
/** 来源 */
@property (nonatomic, copy) NSString *origin;
/** 阅读数 */
@property (nonatomic, assign) int checkNum;
/** 发布时间 */
@property (nonatomic, copy) NSString *releaseTime;
/** 新闻主体 */
@property (nonatomic, copy) NSString *newsContent;


/** 创建人id */
@property (nonatomic, assign) int createUserId;
/** 状态 */
@property (nonatomic, assign) int status;
/** 图片url */
@property (nonatomic, copy) NSString *url;


@end
