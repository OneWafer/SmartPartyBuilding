//
//  OWMsgComment.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/26.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWMsgComment : NSObject

/** id */
@property (nonatomic, assign) int id;
/** 主题id */
@property (nonatomic, assign) int articleId;
/** 父评论id */
@property (nonatomic, assign) int parentId;
/** 管理员id */
@property (nonatomic, assign) int staffId;
/** 是否喜欢 */
@property (nonatomic, assign) int isLiked;
/** 喜欢数量 */
@property (nonatomic, assign) int likeNum;
/** 图像 */
@property (nonatomic, copy) NSString *avatar;
/** 评论内容 */
@property (nonatomic, copy) NSString *content;
/** 管理员姓名 */
@property (nonatomic, copy) NSString *staffName;
/** 发布日期 */
@property (nonatomic, copy) NSString *publishTime;


@end
