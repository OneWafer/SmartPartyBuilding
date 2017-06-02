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

+(NSString *) preettyTime:(long long) ts;

/** 存储已登录的账号 */
+ (void)setUserAct:(NSDictionary *)userAct;
/** 取出已登录的账号 */
+ (NSDictionary *)getUserAct;

@end
