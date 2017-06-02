//
//  OWNetworking.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/10.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWNetworking.h"
#import "AppDelegate.h"

@implementation OWNetworking

+ (void)GET:(NSString *)urlString parameters:(NSDictionary *)parms success:(void (^)(id _Nullable))successBlock failure:(void (^)(NSError * _Nonnull))failureBlock
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    AFHTTPSessionManager *mgr = [app sharedHTTPSession];
    mgr.requestSerializer.timeoutInterval = 15;
    
    [mgr GET:urlString parameters:parms progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) failureBlock(error);
    }];
}


+ (void)HGET:(NSString *)urlString parameters:(NSDictionary *)parms success:(void (^)(id _Nullable))successBlock failure:(void (^)(NSError * _Nonnull))failureBlock
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    NSDictionary *userInfo = [QTTool getUserInfo];
    
    AFHTTPSessionManager *mgr = [app sharedHTTPSession];
    mgr.requestSerializer.timeoutInterval = 15;
    [mgr.requestSerializer setValue:@"2a591b3ee37a14912e0b1d0334eb73ba" forHTTPHeaderField:@"Authentication"];
    
    [mgr GET:urlString parameters:parms progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) failureBlock(error);
    }];
}


+ (void)POST:(NSString *)urlString parameters:(NSDictionary *)parms success:(void (^)(id _Nullable))successBlock failure:(void (^)(NSError * _Nonnull))failureBlock
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    AFHTTPSessionManager *mgr = [app sharedHTTPSession];
    mgr.requestSerializer.timeoutInterval = 15;
    
    [mgr POST:urlString parameters:parms progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) failureBlock(error);
    }];
}

+ (void)HPOST:(NSString *)urlString parameters:(NSDictionary *)parms success:(void (^)(id _Nullable))successBlock failure:(void (^)(NSError * _Nonnull))failureBlock
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    NSDictionary *userInfo = [QTTool getUserInfo];
    
    AFHTTPSessionManager *mgr = [app sharedHTTPSession];
    mgr.requestSerializer.timeoutInterval = 15;
//    [mgr.requestSerializer setValue:userInfo[@"token"] forHTTPHeaderField:@"Authentication"];
    
    [mgr POST:urlString parameters:parms progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) failureBlock(error);
    }];
}



+ (void)POST:(NSString *)urlString parameters:(NSDictionary *)parms constructingBodyWithBlock:(nullable void (^)(id<AFMultipartFormData> _Nonnull))bodyBlock success:(nullable void (^)(id _Nullable))successBlock failure:(nullable void (^)(NSError * _Nonnull))failureBlock
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    AFHTTPSessionManager *mgr = [app sharedHTTPSession];
    mgr.requestSerializer.timeoutInterval = 15;
    
    [mgr POST:urlString parameters:parms constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (bodyBlock) bodyBlock(formData);
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) failureBlock(error);
    }];
}


+ (void)HPOST:(NSString *)urlString parameters:(NSDictionary *)parms constructingBodyWithBlock:(nullable void (^)(id<AFMultipartFormData> _Nonnull))bodyBlock success:(nullable void (^)(id _Nullable))successBlock failure:(nullable void (^)(NSError * _Nonnull))failureBlock
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
//    NSDictionary *userInfo = [QTTool getUserInfo];
    
    AFHTTPSessionManager *mgr = [app sharedHTTPSession];
    mgr.requestSerializer.timeoutInterval = 15;
//    [mgr.requestSerializer setValue:userInfo[@"token"] forHTTPHeaderField:@"Authentication"];
    
    
    [mgr POST:urlString parameters:parms constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (bodyBlock) bodyBlock(formData);
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) successBlock(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) failureBlock(error);
    }];
}


@end
