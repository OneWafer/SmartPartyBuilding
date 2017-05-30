//
//  OWPlusBtn.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/14.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWPlusBtn.h"

@interface OWPlusBtn ()<CYLPlusButtonSubclassing>

@end

@implementation OWPlusBtn

+ (id)plusButton
{
    OWPlusBtn *btn = [[OWPlusBtn alloc] init];
    [btn setImage:wh_imageNamed(@"tab_plus") forState:UIControlStateNormal];
    [btn sizeToFit];
    
    [btn wh_addActionHandler:^(UIButton *sender) {
        wh_Log(@"----");
    }];
    
    return btn;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat const imgViewEdgeWidth   = self.wh_width * 0.85;
    CGFloat const imgViewEdgeHeight   = imgViewEdgeWidth * 0.83;
    
    CGFloat const centerX = self.wh_width * 0.5;
    CGFloat const centerY = self.wh_height * 0.55;
    
    //imageView position 位置
    self.imageView.bounds = CGRectMake(0, 0, imgViewEdgeWidth, imgViewEdgeHeight);
    self.imageView.center = CGPointMake(centerX, centerY);
}

@end
