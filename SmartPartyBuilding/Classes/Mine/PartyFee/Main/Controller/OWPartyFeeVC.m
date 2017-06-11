//
//  OWPartyFeeVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/10.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWPartyFeeVC.h"
#import "OWEdgeLabel.h"

@interface OWPartyFeeVC ()<UITextViewDelegate>

@property (nonatomic, weak) OWEdgeLabel *descLabel;
@property (nonatomic, weak) UIButton *sltBtn;

@end

@implementation OWPartyFeeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"党费缴纳";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    [self setupNavi];
    self.descLabel.text = @"党员目前缴费解释:\n如果您是开发区支部党员，目前党内职务为干事，月缴党费为50.0元。可以在一下列表选择党费缴纳月份，目前系统支持最大6个月，最小1个月。您一次多缴纳数月，则在后续党费费缴纳过程中不会受到系统推送消息和短消息，在您多缴纳月份扣除结束后，您将在最后一次需缴纳前收到短信及app内消息。祝您生活愉快，党感谢您对革命事业的支持!";
    
    [self.sltBtn wh_addActionHandler:^(UIButton *sender) {
        wh_Log(@"---点击了选择月份");
    }];
}

- (void)setupNavi
{
    wh_weakSelf(self);
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem wh_itemWithType:WHItemTypeRight norTitle:@"缴费" font:14.5f norColor:wh_RGB(9, 131, 216) highColor:[UIColor blueColor] offset:0 actionHandler:^(UIButton *sender) {
        wh_Log(@"---点击了缴费");
    }];
}


#pragma mark - ---------- Lazy ----------

- (UILabel *)descLabel
{
    if (!_descLabel) {
        OWEdgeLabel *label = [[OWEdgeLabel alloc] init];
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14.5f];
        label.layer.borderColor = wh_lineColor.CGColor;
        label.numberOfLines = 0;
        label.layer.borderWidth = 0.5;
        [self.view addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(15);
            make.top.equalTo(self.view).offset(79);
            make.right.equalTo(self.view).offset(-15);
        }];
        _descLabel = label;
    }
    return _descLabel;
}


- (UIButton *)sltBtn
{
    if (!_sltBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitle:@"请选择缴费月数" forState:UIControlStateNormal];
        [btn setTitleColor:wh_norFontColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [btn setImage:wh_imageNamed(@"office_down") forState:UIControlStateNormal];
        [self.view addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.descLabel);
            make.top.equalTo(self.descLabel.bottom).offset(10);
            make.height.equalTo(45);
        }];
        
        btn.layer.borderWidth = 0.5;
        btn.layer.borderColor = wh_lineColor.CGColor;
        [btn wh_setImagePosition:WHImagePositionRight spacing:5];
        _sltBtn = btn;
    }
    return _sltBtn;
}

@end
