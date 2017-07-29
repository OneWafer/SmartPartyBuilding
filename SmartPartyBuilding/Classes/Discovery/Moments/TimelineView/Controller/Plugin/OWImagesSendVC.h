//
//  OWImagesSendVC.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/18.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OWImagesSendVCDelegate <NSObject>

@optional

-(void) onSendTextImage:(NSString *) text images:(NSArray *)images location:(NSString *)location;


@end

@interface OWImagesSendVC : UIViewController

@property (nonatomic, weak) id<OWImagesSendVCDelegate> delegate;

- (instancetype)initWithImages:(NSArray *) images;

@end
