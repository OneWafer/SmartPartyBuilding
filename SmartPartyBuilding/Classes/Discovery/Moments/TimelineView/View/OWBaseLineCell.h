//
//  OWBaseLineCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OWBaseLineItem;

#define Margin 15

#define Padding 10

#define UserAvatarSize 40

#define  BodyMaxWidth [UIScreen mainScreen].bounds.size.width - UserAvatarSize - 3*Margin

@protocol OWLineCellDelegate <NSObject>

@optional
- (void) onLike:(long long) itemId;

- (void) onComment:(int) itemId;

- (void) onClickUser:(NSUInteger) userId;

- (void) onClickComment:(long long) commentId itemId:(long long) itemId;

@end

@interface OWBaseLineCell : UITableViewCell

@property (nonatomic, strong) UIView *bodyView;

@property (nonatomic, weak) id<OWLineCellDelegate> delegate;

- (void) updateWithItem:(OWBaseLineItem *) item;

- (CGFloat) getCellHeight:(OWBaseLineItem *) item;

- (CGFloat) getReuseableCellHeight:(OWBaseLineItem *)item;

- (void)updateBodyView:(CGFloat) height;

- (void) hideLikeCommentToolbar;

- (UINavigationController *) getController;

@end
