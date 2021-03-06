//
//  OWInputFuncView.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/25.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^OWInputFuncViewBlock)(NSInteger tag);

@interface OWInputFuncView : UIView

@property (nonatomic, strong) NSDictionary *infoDic;
@property (nonatomic, copy) NSString *commentStr;
@property (nonatomic, weak) UITextField *inputView;
@property (nonatomic, weak) UIButton *collectionBtn;
@property (nonatomic, weak) UIButton *thumbupBtn;
@property (nonatomic, copy) OWInputFuncViewBlock block;

@end
