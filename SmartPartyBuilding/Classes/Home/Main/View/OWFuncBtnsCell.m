//
//  OWFuncBtnsCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/14.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <UIButton+WebCache.h>
#import "OWFuncBtnsCell.h"
#import "OWVerticalBtn.h"

@interface OWFuncBtnsCell ()

@property (nonatomic, assign) CGFloat font;
@property (nonatomic, strong) NSMutableArray *btnList1;
@property (nonatomic, strong) NSMutableArray *btnList2;

@end

@implementation OWFuncBtnsCell

static NSString *const identifier = @"OWFuncBtnsCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWFuncBtnsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWFuncBtnsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


/*
 *  构造方法(在初始化对象的时候会调用)
 *  一般在这个方法中添加需要显示的子控件
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.font = 10.0f;
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.btnList1 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:60 leadSpacing:10 tailSpacing:10];
    [self.btnList1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.height.equalTo(self).multipliedBy(0.5);
    }];
    
    [self.btnList2 mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedItemLength:60 leadSpacing:10 tailSpacing:10];
    [self.btnList2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.equalTo(self).multipliedBy(0.5);
    }];
}

- (void)setTitleDic:(NSDictionary *)titleDic
{
    _titleDic = titleDic;
    NSArray *titleList = titleDic[@"title"];
    NSArray *imgList = titleDic[@"image"];
    [self.btnList1 wh_eachWithIndex:^(UIButton *obj, NSUInteger idx) {
        [obj setTitle:titleList[idx] forState:UIControlStateNormal];
        [obj sd_setImageWithURL:[NSURL URLWithString:imgList[idx]] forState:UIControlStateNormal placeholderImage:wh_imageNamed(@"")];
        [obj sizeToFit];
    }];
    
    [self.btnList2 wh_eachWithIndex:^(UIButton *obj, NSUInteger idx) {
        [obj setTitle:titleList[idx + 4] forState:UIControlStateNormal];
        [obj sd_setImageWithURL:[NSURL URLWithString:imgList[idx]] forState:UIControlStateNormal placeholderImage:wh_imageNamed(@"")];
        [obj sizeToFit];
    }];
}


#pragma mark - ---------- Lazy ----------

- (NSMutableArray *)btnList1
{
    if (!_btnList1) {
        NSMutableArray *list = [NSMutableArray array];
        for (int i = 0; i < 4; i ++) {
            OWVerticalBtn *btn = [OWVerticalBtn buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:wh_norFontColor forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:self.font];
            btn.tag = 1001 + i;
            [self.contentView addSubview:btn];
            [list addObject:btn];
            
            wh_weakSelf(self);
            [btn wh_addActionHandler:^(UIButton *sender) {
                if (weakself.funcBtnBlock) weakself.funcBtnBlock(sender.tag);
            }];
        }
        _btnList1 = list;
    }
    return _btnList1;
}

- (NSMutableArray *)btnList2
{
    if (!_btnList2) {
        NSMutableArray *list = [NSMutableArray array];
        for (int i = 0; i < 4; i ++) {
            OWVerticalBtn *btn = [OWVerticalBtn buttonWithType:UIButtonTypeCustom];
            [btn setTitleColor:wh_norFontColor forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:self.font];
            btn.tag = 1005 + i;
            [self.contentView addSubview:btn];
            [list addObject:btn];
            
            wh_weakSelf(self);
            [btn wh_addActionHandler:^(UIButton *sender) {
                if (weakself.funcBtnBlock) weakself.funcBtnBlock(sender.tag);
            }];
        }
        _btnList2 = list;
    }
    return _btnList2;
}

@end
