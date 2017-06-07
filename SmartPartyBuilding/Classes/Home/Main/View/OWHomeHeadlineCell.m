//
//  OWHomeHeadlineCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/4.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <SDCycleScrollView.h>
#import "OWHomeHeadlineCell.h"
#import "OWNews.h"

@interface OWHomeHeadlineCell ()<SDCycleScrollViewDelegate>

@property (nonatomic, weak) UIImageView *titleImgView;
@property (nonatomic, weak) SDCycleScrollView *headlineView;
@property (nonatomic, weak) UIView *lineView1;
@property (nonatomic, weak) UIView *lineView2;
@property (nonatomic, weak) UILabel *moreLabel;
@property (nonatomic, weak) UIButton *moreBtn;

@end

@implementation OWHomeHeadlineCell

static NSString *const identifier = @"OWHomeHeadlineCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWHomeHeadlineCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWHomeHeadlineCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        [self.moreBtn wh_addActionHandler:^(UIButton *sender) {
            wh_Log(@"点击了更多");
        }];
    }
    return self;
}

- (void)setNewsList:(NSArray *)newsList
{
    _newsList = newsList;
    NSMutableArray *titleList = [NSMutableArray array];
    [newsList wh_each:^(OWNews *obj) {
        [titleList addObject:obj.title];
    }];
    self.headlineView.titlesGroup = [titleList mutableCopy];
}


#pragma mark - ---------- Lazy ----------

- (UIImageView *)titleImgView
{
    if (!_titleImgView) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:wh_imageNamed(@"home_headline")];
        [self.contentView addSubview:imgView];
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(15);
            make.centerY.equalTo(self);
        }];
        _titleImgView = imgView;
    }
    return _titleImgView;
}

- (UIView *)lineView1
{
    if (!_lineView1) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = wh_lineColor;
        [self.contentView addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.titleImgView.right).offset(10);
            make.width.equalTo(0.5);
            make.height.equalTo(self).multipliedBy(0.5);
        }];
        _lineView1 = view;
    }
    return _lineView1;
}

- (UILabel *)moreLabel
{
    if (!_moreLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.text = @"更多";
        label.textColor = wh_norFontColor;
        label.font = [UIFont systemFontOfSize:14.0f];
        [self.contentView addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self).offset(-10);
        }];
        _moreLabel = label;
    }
    return _moreLabel;
}

- (UIView *)lineView2
{
    if (!_lineView2) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = wh_lineColor;
        [self.contentView addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.right.equalTo(self.moreLabel.left).offset(-10);
            make.width.equalTo(0.5);
            make.height.equalTo(self).multipliedBy(0.5);
        }];
        _lineView2 = view;
    }
    return _lineView2;
}

- (SDCycleScrollView *)headlineView
{
    if (!_headlineView) {
        SDCycleScrollView *view = [[SDCycleScrollView alloc] init];
        view.titleLabelBackgroundColor = [UIColor whiteColor];
        view.titleLabelTextColor = wh_norFontColor;
        view.titleLabelTextFont = [UIFont systemFontOfSize:14.0f];
        view.delegate = self;
        view.scrollDirection = UICollectionViewScrollDirectionVertical;
        view.onlyDisplayText = YES;
        view.autoScrollTimeInterval = 4.0f;
        [self.contentView addSubview:view];
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lineView1.right);
            make.right.equalTo(self.lineView2.left).offset(-10);
            make.top.bottom.equalTo(self);
            
        }];
        _headlineView = view;
    }
    return _headlineView;
}


- (UIButton *)moreBtn
{
    if (!_moreBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        _moreBtn = btn;
    }
    return _moreBtn;
}

@end
