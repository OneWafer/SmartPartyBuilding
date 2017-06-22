//
//  OWStoreSectionHeaderView.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/22.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWStoreSectionHeaderView.h"

@interface OWStoreSectionHeaderView ()

@property (nonatomic, weak) UIView *titleView;

@end

@implementation OWStoreSectionHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleView.backgroundColor = wh_RGB(241, 241, 241);
    }
    return self;
}

#pragma mark - ---------- Lazy ----------

- (UIView *)titleView
{
    if (!_titleView) {
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = @"所有兑换";
        titleLabel.textColor = wh_norFontColor;
        titleLabel.font = [UIFont systemFontOfSize:14.5f];
        [view addSubview:titleLabel];
        [titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(view);
        }];
        
        UIView *lineView1 = [[UIView alloc] init];
        lineView1.backgroundColor = wh_lineColor;
        [view addSubview:lineView1];
        [lineView1 makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.left.equalTo(view).offset(15);
            make.right.equalTo(titleLabel.left).offset(-15);
            make.height.equalTo(0.5);
        }];
        
        UIView *lineView2 = [[UIView alloc] init];
        lineView2.backgroundColor = wh_lineColor;
        [view addSubview:lineView2];
        [lineView2 makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(view);
            make.right.equalTo(view).offset(-15);
            make.left.equalTo(titleLabel.right).offset(15);
            make.height.equalTo(0.5);
        }];
        
        
        _titleView = view;
    }
    return _titleView;
}

@end
