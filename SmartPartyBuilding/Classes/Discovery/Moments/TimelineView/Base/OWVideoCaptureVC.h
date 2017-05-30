//
//  OWVideoCaptureVC.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/18.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OWVideoCaptureVCDelegate <NSObject>

@optional

-(void) onCaptureVideo:(NSString *) filePath screenShot:(UIImage *) screenShot;

@end

@interface OWVideoCaptureVC : UIViewController

@property (nonatomic, assign) id<OWVideoCaptureVCDelegate> delegate;

-(void) onCaptureVideo:(NSString *) filePath screenShot:(UIImage *) screenShot;

@end
