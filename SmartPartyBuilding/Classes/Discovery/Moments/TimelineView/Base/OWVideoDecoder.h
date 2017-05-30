//
//  OWVideoDecoder.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/18.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OWVideoDecoderDelegate <NSObject>

@required

-(void) onDecodeFinished;

@end

@interface OWVideoDecoder : NSObject

@property (nonatomic, strong) CAKeyframeAnimation *animation;

@property (nonatomic, strong) id<OWVideoDecoderDelegate> delegate;

- (instancetype)initWithFile:(NSString *) filePath;

- (void) decode;

@end
