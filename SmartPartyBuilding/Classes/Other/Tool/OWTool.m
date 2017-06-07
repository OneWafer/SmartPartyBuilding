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


+(NSString *)preettyTime:(long long)ts
{
    //原有时间
    NSString *firstDateStr=[OWTool FormatTime:@"yyyy-MM-dd" timeInterval:ts];
    NSArray *firstDateStrArr=[firstDateStr componentsSeparatedByString:@"-"];
    
    //现在时间
    NSDate *now = [NSDate date];
    NSDateComponents *componentsNow = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:now];
    NSString *nowDateStr = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)[componentsNow year], (long)[componentsNow month], (long)[componentsNow day]];
    NSArray *nowDateStrArr = [nowDateStr componentsSeparatedByString:@"-"];
    
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:ts/1000];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    
    //同年
    if ([firstDateStrArr[0] intValue] == [nowDateStrArr[0] intValue]){
        
        //当天
        if( [firstDateStrArr[1] intValue] == [nowDateStrArr[1] intValue] && [nowDateStrArr[2] intValue]== [firstDateStrArr[2] intValue]){
            [dateformatter setDateFormat:@"HH:mm"];
            return [NSString stringWithFormat:@"%@", [dateformatter stringFromDate:date]];
        }
        
        //昨天
        if( [firstDateStrArr[1] intValue]==[nowDateStrArr[1] intValue] && ([nowDateStrArr[2] intValue]-[firstDateStrArr[2] intValue]==1)){
            [dateformatter setDateFormat:@"HH:mm"];
            return [NSString stringWithFormat:@"昨天 %@", [dateformatter stringFromDate:date]];
            
        }else{//昨天之前
            [dateformatter setDateFormat:@"MM-dd HH:mm"];
            return  [dateformatter stringFromDate:date];
        }
        
    }else{
        [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        return [dateformatter stringFromDate:date];
    }
    
}

+ (NSString *)FormatTime:(NSString *)format timeInterval:(double)value;
{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:value / 1000];
    [dateformatter setDateFormat:format];
    return [dateformatter stringFromDate:date];
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

@end
