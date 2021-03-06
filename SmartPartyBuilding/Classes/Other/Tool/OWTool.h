//
//  OWTool.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWTool : NSObject

/** 设置SVProgressHUD */
+ (void)SVProgressHUD;
/** md5加密 */
+(NSString *) md5:(NSString *) str;

+(NSString *) preettyTime:(double) ts;

/** 存储token */
+ (void)setToken:(NSString *)token;
/** 取出token */
+ (NSString *)getToken;

/** 存储已登录的账号 */
+ (void)setUserAct:(NSDictionary *)userAct;
/** 取出已登录的账号 */
+ (NSDictionary *)getUserAct;

/** 存储用户信息 */
+ (void)setUserInfo:(NSDictionary *)userInfo;
/** 取出用户信息 */
+ (NSDictionary *)getUserInfo;

/** 处理html图片大小 */
+ (NSString *)filtrationHtml:(NSString *)contentHtml;


@end
