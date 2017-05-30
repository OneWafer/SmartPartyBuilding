//
//  OWLinkClickLabel.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWLinkClickLabel.h"

@implementation OWLinkClickLabel

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
    
    MLLink *link = [self linkAtPoint:[touch locationInView:self]];
    if (!link) {
        wh_Log(@"单击了非链接部分");
        if (_clickDelegate && [_clickDelegate respondsToSelector:@selector(onClickOutsideLink:)]) {
            [_clickDelegate onClickOutsideLink:_uniqueId];
        }
    }
    
    self.backgroundColor = [UIColor clearColor];
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    self.backgroundColor = [UIColor lightGrayColor];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    self.backgroundColor = [UIColor clearColor];
}


@end
