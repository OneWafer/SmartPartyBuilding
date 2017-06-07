//
//  OWRegisterNavigationVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/24.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWRegisterNavigationVC.h"

@interface OWRegisterNavigationVC ()<UIGestureRecognizerDelegate>

@end

@implementation OWRegisterNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /** 全屏滑动返回 */
    [self setupFullScreenGes];
}


/** 只会调用一次 */
+ (void)initialize
{
    UINavigationBar *naviBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    [naviBar setBackgroundImage:[UIImage wh_imgWithColor:wh_RGBA(255, 255, 255, 0.95)] forBarMetrics:(UIBarMetricsDefault)];
    
    // 只要是通过模型设置,都是通过富文本设置
    // 设置导航条标题
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:18.0f];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [naviBar setTitleTextAttributes:attrs];
    
    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:wh_imageNamed(@"navi_back_white") forState:UIControlStateNormal];
        [backBtn setTitle:@"返回" forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        backBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [backBtn sizeToFit];
        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -12, 0, 0);
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        UIView *containVew = [[UIView alloc] initWithFrame:backBtn.bounds];
        [containVew addSubview:backBtn];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:containVew];
        // push后隐藏tabBar
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 返回按钮点击事件处理
        wh_weakSelf(self);
        [backBtn wh_addActionHandler:^(UIButton *sender) {
            [weakself popViewControllerAnimated:YES];
        }];
    }
    
    [super pushViewController:viewController animated:animated];
}

/** 全屏滑动返回 */
- (void)setupFullScreenGes
{
    id target = self.interactivePopGestureRecognizer.delegate;
    SEL handler = NSSelectorFromString(@"handleNavigationTransition:");
    // 获取添加系统边缘触发手势的View
    UIView *targetView = self.interactivePopGestureRecognizer.view;
    
    // 创建全屏手势
    UIPanGestureRecognizer *fullScreenGes = [[UIPanGestureRecognizer alloc] initWithTarget:target action:handler];
    fullScreenGes.delegate = self;
    [targetView addGestureRecognizer:fullScreenGes];
    
    // 关闭边缘触发手势 防止和原有边缘手势冲突
    self.interactivePopGestureRecognizer.enabled = NO;
}


/** 是否触发右滑返回手势 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    return self.childViewControllers.count > 1;
}


@end
