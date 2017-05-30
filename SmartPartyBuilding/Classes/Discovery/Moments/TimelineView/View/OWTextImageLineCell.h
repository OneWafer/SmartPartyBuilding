//
//  OWTextImageLineCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/18.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWBaseLineCell.h"
@class OWGridImageView;

@interface OWTextImageLineCell : OWBaseLineCell

@property (strong, nonatomic) OWGridImageView *gridImageView;

- (NSInteger) getIndexFromPoint:(CGPoint) point;

@end
