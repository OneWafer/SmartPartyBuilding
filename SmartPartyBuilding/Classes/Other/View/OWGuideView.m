//
//  OWGuideView.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/26.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWGuideView.h"

@implementation OWGuideView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        /** 添加scrollView */
        UIScrollView *guideView = [[UIScrollView alloc] init];
        [self addSubview:guideView];
        [guideView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        guideView.contentSize = CGSizeMake(wh_screenWidth*3, wh_screenHeight);
        guideView.pagingEnabled = YES;
        guideView.showsHorizontalScrollIndicator = NO;
        guideView.bounces = NO;
        
        NSArray *imgList = @[@"guide_01.jpg",@"guide_02.jpg",@"guide_03.jpg"];
        for (int i = 0; i < 3; i ++) {
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(wh_screenWidth*i, 0, wh_screenWidth, wh_screenHeight)];
            imgView.image = [UIImage imageNamed:imgList[i]];
            [guideView addSubview:imgView];
            
        }
        
        UIButton *enterBtn = [[UIButton alloc] initWithFrame:CGRectMake(2.2*wh_screenWidth, 0.7*wh_screenHeight, 0.6*wh_screenWidth, 0.15*wh_screenHeight)];
        wh_weakSelf(self);
        [guideView addSubview:enterBtn];
        [enterBtn wh_addActionHandler:^(UIButton *sender) {
            [UIView animateWithDuration:1 animations:^{
                
                CATransform3D transform = CATransform3DMakeScale(1.5, 1.5, 1.0);
                weakself.layer.transform = transform;
                weakself.alpha = 0.0;
                
            } completion:^(BOOL finished) {
                [weakself removeFromSuperview];
            }];
        }];
    }
    return self;
}


+ (void)push
{
    NSString *key = @"CFBundleShortVersionString";
    
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    // 获得沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        OWGuideView *guideView = [[OWGuideView alloc] init];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

//- (void)enterBtnClick
//{
//    [UIView animateWithDuration:1 animations:^{
//
//        CATransform3D transform = CATransform3DMakeScale(1.5, 1.5, 1.0);
//        self.layer.transform = transform;
//        self.alpha = 0.0;
//
//    } completion:^(BOOL finished) {
//        [self removeFromSuperview];
//    }];
//}

@end
