//
//  OWImagePreviewVC.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/18.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OWImagePreviewVCDelegate <NSObject>

- (void)onLike:(long long) itemId;

- (void)onComment:(long long) itemId;

@end


@interface OWImagePreviewVC : UIViewController

@property (nonatomic, weak) id<OWImagePreviewVCDelegate> delegate;

- (instancetype)initWithImageUrl:(NSString *) url itemId:(long long)itemId;

@end
