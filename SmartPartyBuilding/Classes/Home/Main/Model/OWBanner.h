//
//  OWBanner.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/7.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWBanner : NSObject

/** 图片id*/
@property (nonatomic, assign) int id;
/** 图片url */
@property (nonatomic, copy) NSString *url;
/** 跳转类型 */
@property (nonatomic, assign) int type;
/** 功能点 */
@property (nonatomic, copy) NSString *toFunction;
/** 名称 */
@property (nonatomic, copy) NSString *name;
/** 备注 */
@property (nonatomic, copy) NSString *back;
/** 创建时间 */
@property (nonatomic, copy) NSString *createTime;

@end
