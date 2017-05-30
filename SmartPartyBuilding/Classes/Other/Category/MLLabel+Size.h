//
//  MLLabel+Size.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <MLLabel/MLLabel.h>
#import <MLLinkLabel.h>

@interface MLLabel (Size)

+(CGSize) getViewSize:(NSAttributedString *)attributedText maxWidth:(CGFloat) maxWidth font:(UIFont *) font lineHeight:(CGFloat) lineHeight lines:(NSUInteger)lines;


+(CGSize) getViewSizeByString:(NSString *)text maxWidth:(CGFloat) maxWidth font:(UIFont *) font lineHeight:(CGFloat) lineHeight lines:(NSUInteger)lines;

+(CGSize) getViewSizeByString:(NSString *)text maxWidth:(CGFloat) maxWidth font:(UIFont *) font;

+(CGSize) getViewSizeByString:(NSString *)text font:(UIFont *) font;

@end
