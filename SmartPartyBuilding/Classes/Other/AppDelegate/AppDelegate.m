//
//  AppDelegate.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/9.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <AFHTTPSessionManager.h>
#import "AppDelegate.h"
#import "OWPlusBtn.h"
#import "OWTabBarControllerConfig.h"
#import "OWNavigationController.h"
#import "OWRegisterNavigationVC.h"
#import "OWLoginVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    /** 初始化window */
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [OWPlusBtn registerPlusButton];
    OWTabBarControllerConfig *tabBarControllerConfig = [[OWTabBarControllerConfig alloc] init];
    self.window.rootViewController = tabBarControllerConfig.tabBarController;
//    self.window.rootViewController = [[OWRegisterNavigationVC alloc] initWithRootViewController:[[OWLoginVC alloc] init]];
    [self.window makeKeyAndVisible];
    
    return YES;
}


/** AFNetworking单例 */
static AFHTTPSessionManager *mgr;

- (AFHTTPSessionManager *)sharedHTTPSession
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [AFHTTPSessionManager manager];
    });
    return mgr;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
