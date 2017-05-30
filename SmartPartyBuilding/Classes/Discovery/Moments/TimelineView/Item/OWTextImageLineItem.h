//
//  OWTextImageLineItem.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWBaseLineItem.h"

@interface OWTextImageLineItem : OWBaseLineItem

@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSMutableArray *thumbImages;
@property (nonatomic, strong) NSMutableArray *thumbPreviewImages;
@property (nonatomic, strong) NSMutableArray *srcImages;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) NSAttributedString *attrText;

@end
