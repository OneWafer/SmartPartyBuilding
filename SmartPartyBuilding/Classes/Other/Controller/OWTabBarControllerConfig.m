//
//  OWTabBarControllerConfig.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/14.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWTabBarControllerConfig.h"
#import "OWNavigationController.h"
#import "OWHomeVC.h"
#import "OWStoreVC.h"
#import "OWOfficeVC.h"
#import "OWDiscoveryVC.h"
#import "OWMineVC.h"

@interface OWTabBarControllerConfig ()

@end
@implementation OWTabBarControllerConfig


- (NSArray *)viewControllers
{
    OWNavigationController *homeVC = [[OWNavigationController alloc] initWithRootViewController:[[OWHomeVC alloc] init]];
//    OWNavigationController *officeVC = [[OWNavigationController alloc] initWithRootViewController:[[OWOfficeVC alloc] init]];
    OWNavigationController *storeVC = [[OWNavigationController alloc] initWithRootViewController:[[OWStoreVC alloc] init]];
    OWNavigationController *discoveryVC = [[OWNavigationController alloc] initWithRootViewController:[[OWDiscoveryVC alloc] init]];
    OWNavigationController *mineVC = [[OWNavigationController alloc] initWithRootViewController:[[OWMineVC alloc] init]];
    
    NSArray *list = @[homeVC, storeVC, discoveryVC, mineVC];
    
    return list;
}


- (NSArray *)tabBarItemsAttributesForController
{
    NSDictionary *homeItemAttributes = @{
                                       CYLTabBarItemTitle : @"首页",
                                       CYLTabBarItemImage : @"tab_home",
                                       CYLTabBarItemSelectedImage : @"tab_home_slt"
                                       };
    
    NSDictionary *storeItemAttributes = @{
                                         CYLTabBarItemTitle : @"商城",
                                         CYLTabBarItemImage : @"tab_store",
                                         CYLTabBarItemSelectedImage : @"tab_store_slt"
                                         };
    
    NSDictionary *discoveryItemAttributes = @{
                                         CYLTabBarItemTitle : @"发现",
                                         CYLTabBarItemImage : @"tab_discovery",
                                         CYLTabBarItemSelectedImage : @"tab_discovery_slt"
                                         };
    
    NSDictionary *mineItemAttributes = @{
                                         CYLTabBarItemTitle : @"我",
                                         CYLTabBarItemImage : @"tab_mine",
                                         CYLTabBarItemSelectedImage : @"tab_mine_slt"
                                         };
    
    NSArray *list = @[homeItemAttributes, storeItemAttributes, discoveryItemAttributes, mineItemAttributes];
    
    return list;
}


/** TabBar自定义设置 */
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController
{
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = wh_RGB(167, 167, 167);
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = wh_RGB(217, 17, 23);
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

#pragma mark - ---------- Lazy ----------

- (CYLTabBarController *)tabBarController
{
    if (!_tabBarController) {
        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers tabBarItemsAttributes:self.tabBarItemsAttributesForController];
        
        [self customizeTabBarAppearance:tabBarController];
        
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

@end
