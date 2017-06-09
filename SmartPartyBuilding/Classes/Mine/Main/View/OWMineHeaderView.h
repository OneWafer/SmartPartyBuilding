//
//  OWMineHeaderView.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/15.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OWMineHeaderBlock)(NSInteger tag);

@interface OWMineHeaderView : UIView

@property (nonatomic, copy) OWMineHeaderBlock headerBlock;
@property (nonatomic, weak) UIImageView *headImgView;

@end
