//
//  OWBaseLineItem.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWBaseLineItem : NSObject

//时间轴itemID 需要全局唯一 一般服务器下发
@property (nonatomic, assign) long long itemId;

@property (nonatomic, assign) CGFloat cellHeight;

@property (nonatomic, assign) NSUInteger userId;
@property (nonatomic, strong) NSString *userNick;
@property (nonatomic, strong) NSString *userAvatar;

@property (nonatomic, strong) NSString *title;


@property (nonatomic, strong) NSString *location;

@property (nonatomic, assign) long long ts;


@property (nonatomic, strong) NSMutableArray *likes;
@property (nonatomic, strong) NSMutableArray *comments;


@property (nonatomic, strong) NSMutableAttributedString *likesStr;

@property (nonatomic, strong) NSMutableArray *commentStrArray;

@end
