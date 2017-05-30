//
//  OWCommodityItemCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/29.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OWCommodityItemCellBlock)();

@interface OWCommodityItemCell : UICollectionViewCell

@property (nonatomic, copy) OWCommodityItemCellBlock block;
@end
