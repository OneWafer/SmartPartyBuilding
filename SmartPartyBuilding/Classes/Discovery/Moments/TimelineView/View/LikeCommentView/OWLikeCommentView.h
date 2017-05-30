//
//  OWLikeCommentView.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OWBaseLineItem;

@protocol OWLikeCommentViewDelegate <NSObject>

@required
-(void) onClickUser:(NSUInteger) userId;
-(void) onClickComment:(long long) commentId;

@end


@interface OWLikeCommentView : UIView

@property (nonatomic, weak) id<OWLikeCommentViewDelegate> delegate;


-(void) updateWithItem:(OWBaseLineItem *) item;

+(CGFloat) getHeight:(OWBaseLineItem *) item maxWidth:(CGFloat)maxWidth;

@end
