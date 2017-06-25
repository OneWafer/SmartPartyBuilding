//
//  UIView+KeyBoardShowAndHidden.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/25.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (KeyBoardShowAndHidden)

/**  键盘辅助视图显示动画 */
- (void)showAccessoryViewAnimation;

/** 键盘辅助视图隐藏动画 */
- (void)hiddenAccessoryViewAnimation;

@end
