//
//  OWVerticalBtn.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/14.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWVerticalBtn.h"

@implementation OWVerticalBtn

- (instancetype)init
{
    if ([super init]) {
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat edge = self.wh_width * 0.15;
    CGFloat imgWidth = self.wh_width * 0.7;
    self.imageView.frame = CGRectMake(edge, edge, imgWidth, imgWidth);
    self.titleLabel.frame = CGRectMake(0, self.wh_height - edge*2, self.wh_width, edge*2);
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
@end
