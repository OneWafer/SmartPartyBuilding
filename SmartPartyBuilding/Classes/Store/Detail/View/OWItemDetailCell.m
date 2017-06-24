//
//  OWItemDetailCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/23.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWItemDetailCell.h"
#import "OWStoreItem.h"

@interface OWItemDetailCell ()<UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *detailView;

@end

@implementation OWItemDetailCell

static NSString *const identifier = @"OWItemDetailCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWItemDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWItemDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        
    }
    return self;
}

- (void)setItem:(OWStoreItem *)item
{
    _item = item;
    [self.detailView loadHTMLString:item.introduce baseURL:nil];
}

#pragma mark - ---------- Lazy ----------

- (UIWebView *)detailView
{
    if (!_detailView) {
        UIWebView *view = [[UIWebView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.userInteractionEnabled = NO;
        view.delegate = self;
        
        [self.contentView addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        _detailView = view;
    }
    return _detailView;
}

@end
