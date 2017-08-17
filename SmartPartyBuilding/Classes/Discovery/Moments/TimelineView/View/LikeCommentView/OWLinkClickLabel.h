//
//  OWLinkClickLabel.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <MLLinkLabel.h>

@protocol OWLinkClickLabelDelegate <NSObject>

@optional

-(void) onClickOutsideLink:(int) uniqueId;
-(void) onLongPress;

@end

@interface OWLinkClickLabel : MLLinkLabel

@property (nonatomic, assign) id<OWLinkClickLabelDelegate> clickDelegate;

@property (nonatomic, assign) long long uniqueId;
@end
