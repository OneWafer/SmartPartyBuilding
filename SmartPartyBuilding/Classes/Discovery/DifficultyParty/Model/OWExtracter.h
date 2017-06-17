//
//  OWExtracter.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  提取器(用于从多层嵌套的数据结构中根据路径提取数据)
 */
@interface OWExtracter : NSObject

@property (nonatomic, copy) NSString *value;
@property (nonatomic, strong) NSMutableArray <OWExtracter *> * subExts;

- (instancetype)initWithValue:(NSString *)value;

/**
 *  针对多层数据嵌套的解析
 *  keyPath指令: "->"代表往下解析, "."代表取出当前数组元素的某个值作为目标, "."的个数代表pickerView组件的个数
 *  example: @"->provices.name->cities.name"
 */
+ (OWExtracter *)parseEntity:(id)entity keyPath:(NSString *)keyPath;

@end
