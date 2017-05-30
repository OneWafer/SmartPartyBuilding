//
//  OWTimeLineVC.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWBaseTimeLineVC.h"
@class OWBaseLineItem;
@class OWLineLikeItem;
@class OWLineCommentItem;
@interface OWTimeLineVC : OWBaseTimeLineVC

//添加到末尾
-(void) addItem:(OWBaseLineItem *) item;

//添加到头部
-(void) addItemTop:(OWBaseLineItem *) item;

//根据ID删除
-(void) deleteItem:(long long) itemId;

//赞
-(void) addLikeItem:(OWLineLikeItem *) likeItem itemId:(long long) itemId;

//评论
-(void) addCommentItem:(OWLineCommentItem *) commentItem itemId:(long long) itemId replyCommentId:(long long) replyCommentId;


//发送图文
-(void)onSendTextImage:(NSString *)text images:(NSArray *)images;

//发送视频消息
-(void)onSendVideo:(NSString *)text videoPath:(NSString *)videoPath screenShot:(UIImage *) screenShot;

@end
