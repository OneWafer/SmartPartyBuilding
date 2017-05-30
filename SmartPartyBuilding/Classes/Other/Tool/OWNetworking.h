//
//  OWNetworking.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/10.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <AFHTTPSessionManager.h>
#import <Foundation/Foundation.h>

@interface OWNetworking : NSObject

+ (void)GET:(NSString * _Nonnull)urlString parameters:(NSDictionary * _Nullable)parms success:(nullable void(^)(id _Nullable responseObject))successBlock failure :(nullable void(^)(NSError * _Nonnull error))failureBlock;

+ (void)HGET:(NSString * _Nonnull)urlString parameters:(NSDictionary * _Nullable)parms success:(nullable void(^)(id _Nullable responseObject))successBlock failure :(nullable void(^)(NSError * _Nonnull error))failureBlock;

+ (void)POST:(NSString * _Nonnull)urlString parameters:(NSDictionary * _Nullable)parms success:(nullable void(^)(id _Nullable responseObject))successBlock failure :(nullable void(^)(NSError * _Nonnull error))failureBlock;

+ (void)HPOST:(NSString * _Nonnull)urlString parameters:(NSDictionary * _Nullable)parms success:(nullable void(^)(id _Nullable responseObject))successBlock failure :(nullable void(^)(NSError * _Nonnull error))failureBlock;

+ (void)POST:(NSString * _Nonnull)urlString parameters:(NSDictionary * _Nullable)parms constructingBodyWithBlock:(nullable void(^)(id<AFMultipartFormData>  _Nonnull formData))bodyBlock success:(nullable void(^)(id _Nullable responseObject))successBlock failure :(nullable void(^)(NSError * _Nonnull error))failureBlock;

+ (void)HPOST:(NSString * _Nonnull)urlString parameters:(NSDictionary * _Nullable)parms constructingBodyWithBlock:(nullable void(^)(id<AFMultipartFormData> _Nonnull formData))bodyBlock success:(nullable void(^)(id _Nullable responseObject))successBlock failure :(nullable void(^)(NSError * _Nonnull error))failureBlock;

@end
