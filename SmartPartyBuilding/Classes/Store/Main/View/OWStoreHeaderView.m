//
//  OWStoreHeaderView.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/22.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <MJExtension.h>
#import <SDCycleScrollView.h>
#import "OWStoreHeaderView.h"
#import "OWBanner.h"

@interface OWStoreHeaderView ()<SDCycleScrollViewDelegate>

@property (nonatomic, weak) SDCycleScrollView *banner;
@property (nonatomic, weak) UIView *funcView;
@property (nonatomic, weak) UILabel *scoreLabel;
@property (nonatomic, weak) UIButton *exchangeBtn;
@property (nonatomic, weak) UIView *titleView;

@end

@implementation OWStoreHeaderView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.funcView.backgroundColor = [UIColor whiteColor];
        [self.exchangeBtn wh_addActionHandler:^(UIButton *sender) {
            wh_Log(@"---点击了兑换记录");
        }];
        self.titleView.backgroundColor = wh_RGB(241, 241, 241);
    }
    return self;
}

- (void)setInfoDic:(NSDictionary *)infoDic
{
    _infoDic = infoDic;
    self.banner.imageURLStringsGroup = infoDic[@"banner"];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"积分: %@",infoDic[@"score"]]];
    [str addAttribute:NSForegroundColorAttributeName value:wh_RGB(28, 184, 235) range:NSMakeRange(4,str.length - 4)];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15.5f] range:NSMakeRange(4,str.length - 4)];
    self.scoreLabel.attributedText = str;
}

#pragma mark - ---------- Lazy ----------

- (SDCycleScrollView *)banner
{
    if (!_banner) {
        SDCycleScrollView *banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:wh_imageNamed(@"home_banner_place")];
        banner.currentPageDotColor = [UIColor redColor];
        banner.autoScrollTimeInterval = 3.0f;
        [self addSubview:banner];
        
        [banner makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.equalTo(183);
        }];
        _banner = banner;
    }
    return _banner;
}

- (UIView *)funcView
{
    if (!_funcView) {
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.banner.bottom);
            make.height.equalTo(35);
        }];
        _funcView = view;
    }
    return _funcView;
}

- (UILabel *)scoreLabel
{
    if (!_scoreLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textColor = wh_norFontColor;
        label.font = [UIFont systemFontOfSize:14.5f];
        [self.funcView addSubview:label];
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.funcView);
            make.centerX.equalTo(self.funcView).multipliedBy(0.5);
        }];
        _scoreLabel = label;
    }
    return _scoreLabel;
}

- (UIButton *)exchangeBtn
{
    if (!_exchangeBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"兑换记录" forState:UIControlStateNormal];
        [btn setTitleColor:wh_norFontColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.5f];
        [self.funcView addSubview:btn];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self.funcView);
            make.width.equalTo(self.funcView).multipliedBy(0.5);
        }];
        _exchangeBtn = btn;
    }
    return _exchangeBtn;
}

- (UIView *)titleView
{
    if (!_titleView) {
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(self.funcView.bottom);
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
