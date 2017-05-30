//
//  OWBaseUserLineCell.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/19.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OWBaseUserLineItem;
@protocol OWBaseUserLineCellDelegate <NSObject>

@required

-(void) onClickItem:(OWBaseUserLineItem *) item;

@end

@interface OWBaseUserLineCell : UITableViewCell

@property (nonatomic, weak) id<OWBaseUserLineCellDelegate> delegate;


@property (nonatomic, strong) UIButton *bodyView;


-(void) updateWithItem:(OWBaseUserLineItem *) item;

-(CGFloat) getCellHeight:(OWBaseUserLineItem *) item;


-(void) updateBodyWithHeight:(CGFloat)height;

@end
