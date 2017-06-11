//
//  AppDelegate.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/9.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AFHTTPSessionManager;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void)tabBar;
- (void)login;

/** AFNetworking单利,防止内存泄漏 */
- (AFHTTPSessionManager *)sharedHTTPSession;


@end

