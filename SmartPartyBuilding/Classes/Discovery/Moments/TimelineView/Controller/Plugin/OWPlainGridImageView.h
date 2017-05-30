//
//  OWPlainGridImageView.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OWPlainGridImageViewDelegate <NSObject>

@optional

-(void) onClick:(NSUInteger) index;
-(void) onLongPress:(NSUInteger) index;

@end

@interface OWPlainGridImageView : UIView

@property (nonatomic, weak) id<OWPlainGridImageViewDelegate> delegate;

+(CGFloat)getHeight:(NSMutableArray *)images maxWidth:(CGFloat)maxWidth;

-(void)updateWithImages:(NSMutableArray *)images;

@end
