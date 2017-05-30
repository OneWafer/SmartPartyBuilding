//
//  OWVideoLineItem.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWBaseLineItem.h"
@class OWVideoDecoder;

@interface OWVideoLineItem : OWBaseLineItem

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) UIImage *thumbImage;
@property (nonatomic, strong) NSString *thumbUrl;

@property (nonatomic, strong) NSString *videoUrl;
@property (nonatomic, strong) NSString *localVideoPath;

@property (nonatomic, strong) NSAttributedString *attrText;

@property (nonatomic, strong) OWVideoDecoder *decorder;

@end
