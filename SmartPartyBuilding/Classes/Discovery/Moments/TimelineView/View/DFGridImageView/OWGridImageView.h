//
//  OWGridImageView.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OWGridImageView : UIView

-(void) updateWithImages:(NSMutableArray *)images srcImages:(NSMutableArray *)srcImages oneImageWidth:(CGFloat)oneImageWidth oneImageHeight:(CGFloat)oneImageHeight;

+(CGFloat) getHeight:(NSMutableArray *) images maxWidth:(CGFloat)maxWidth oneImageWidth:(CGFloat)oneImageWidth oneImageHeight:(CGFloat)oneImageHeight;

-(NSInteger) getIndexFromPoint: (CGPoint) point;

@end
