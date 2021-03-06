//
//  OWRefreshGifHeader.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/7.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWRefreshGifHeader.h"

@implementation OWRefreshGifHeader

#pragma mark - 重写父类的方法
- (void)prepare{
    [super prepare];
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
    for (int i = 1; i<=4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_flag%d", i]];
        [idleImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (int i = 1; i<=4; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh_flag%d", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
    
    // 隐藏时间
    self.lastUpdatedTimeLabel.hidden = YES;
    // 自动调节透明度
    self.automaticallyChangeAlpha = YES;
    //隐藏状态
//    self.stateLabel.hidden = YES;
}

@end
