//
//  OWTool.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <SVProgressHUD.h>
#import <CommonCrypto/CommonDigest.h>
#import "OWTool.h"

NSString *const UserAct = @"userAct";
NSString *const Token = @"token";
NSString *const UserInfo = @"userInfo";

@implementation OWTool

+ (void)SVProgressHUD
{
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
    [SVProgressHUD setMinimumDismissTimeInterval:1.5];
    [SVProgressHUD setMaxSupportedWindowLevel:2];
    [SVProgressHUD setMinimumSize:CGSizeMake(110, 110)];
}

+(NSString *)md5:(NSString *)str
{
    if (str == nil) {
        return @"";
    }
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    
}


+(NSString *)preettyTime:(double)ts
{
    //原有时间
    NSString *firstDateStr = [NSDate wh_getDateStirngWithTimestamp:[NSString stringWithFormat:@"%f",ts] Format:@"yyyy-MM-dd"];
    wh_Log(@"%@",firstDateStr);
    NSArray *firstDateStrArr=[firstDateStr componentsSeparatedByString:@"-"];
    
    //现在时间
    NSDate *now = [NSDate date];
    NSDateComponents *componentsNow = [[NSCalendar currentCalendar] components:kCFCalendarUnitDay | kCFCalendarUnitMonth | kCFCalendarUnitYear fromDate:now];
    NSString *nowDateStr = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)[componentsNow year], (long)[componentsNow month], (long)[componentsNow day]];
    NSArray *nowDateStrArr = [nowDateStr componentsSeparatedByString:@"-"];
    
    
    NSString *dateStr = [NSString stringWithFormat:@"%f",ts];
    
    //同年
    if ([firstDateStrArr[0] intValue] == [nowDateStrArr[0] intValue]){
        
        //当天
        if( [firstDateStrArr[1] intValue] == [nowDateStrArr[1] intValue] && [nowDateStrArr[2] intValue]== [firstDateStrArr[2] intValue]){
            return [NSDate wh_getDateStirngWithTimestamp:dateStr Format:@"HH:mm"];
        }
        
        //昨天
        if( [firstDateStrArr[1] intValue]==[nowDateStrArr[1] intValue] && ([nowDateStrArr[2] intValue]-[firstDateStrArr[2] intValue]==1)){
            return [NSString stringWithFormat:@"昨天 %@", [NSDate wh_getDateStirngWithTimestamp:dateStr Format:@"HH:mm"]];
            
        }else{//昨天之前
            return [NSDate wh_getDateStirngWithTimestamp:dateStr Format:@"MM-dd HH:mm"];
        }
        
    }else{
        return [NSDate wh_getDateStirngWithTimestamp:dateStr Format:@"yyyy-MM-dd HH:mm"];
    }
    
}


/** 存储token */
+ (void)setToken:(NSString *)token
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:token forKey:Token];
    [userDefaults synchronize];
}
/** 取出token */
+ (NSString *)getToken
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:Token];
}


/** 存储已登录的账号 */
+ (void)setUserAct:(NSDictionary *)userAct
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:userAct forKey:UserAct];
    [userDefaults synchronize];
}
/** 取出已登录的账号 */
+ (NSDictionary *)getUserAct
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:UserAct];
}


/** 存储用户信息 */
+ (void)setUserInfo:(NSDictionary *)userInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:userInfo forKey:UserInfo];
    [userDefaults synchronize];
}
/** 取出用户信息 */
+ (NSDictionary *)getUserInfo
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:UserInfo];
}


/** 处理html图片大小 */
+ (NSString *)filtrationHtml:(NSString *)contentHtml
{
    NSString *str = [NSString stringWithFormat:@"<html> \n"
                       "<head> \n"
                       "<style type=\"text/css\"> \n"
                       "body {font-size:15px;}\n"
                       "</style> \n"
                       "</head> \n"
                       "<body>"
                       "<script type='text/javascript'>"
                       "window.onload = function(){\n"
                       "var $img = document.getElementsByTagName('img');\n"
                       "for(var p in  $img){\n"
                       " $img[p].style.width = '100%%';\n"
                       "$img[p].style.height ='auto'\n"
                       "}\n"
                       "}"
                       "</script>%@"
                       "</body>"
                       "</html>",contentHtml];
    return str;
}

@end
