//
//  OWLikeCommentToolbar.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OWLikeCommentToolbarDelegate <NSObject>

@required

-(void) onLike;
-(void) onComment;

@end

@interface OWLikeCommentToolbar : UIImageView

@property (nonatomic, assign) int momentId;
@property (nonatomic, weak) id<OWLikeCommentToolbarDelegate> delegate;
@property (nonatomic, copy) NSString *num;
@end
