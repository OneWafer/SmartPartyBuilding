//
//  OWCommentInputView.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OWCommentInputViewDelegate <NSObject>

@required

-(void) onCommentCreate:(long long ) commentId text:(NSString *) text;


@end

@interface OWCommentInputView : UIView

@property (nonatomic, weak) id<OWCommentInputViewDelegate> delegate;

@property (nonatomic, assign) long long commentId;

-(void) addNotify;

-(void) removeNotify;

-(void) addObserver;

-(void) removeObserver;

-(void) show;

-(void) setPlaceHolder:(NSString *) text;

@end
