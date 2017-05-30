//
//  OWCommodityFallCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/29.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <XHWaterfallFlowLayout.h>
#import "OWCommodityFallCell.h"
#import "OWCommodityItemCell.h"

@interface OWCommodityFallCell ()<UICollectionViewDelegate,UICollectionViewDataSource,XHWaterfallFlowLayoutDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property(nonatomic, strong) XHWaterfallFlowLayout *flowLayout;

@end

@implementation OWCommodityFallCell

static NSString * const ItemCellId = @"OWCommodityItemCellId";

static NSString *const identifier = @"OWCommodityFallCell";
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    OWCommodityFallCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[OWCommodityFallCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
        [self setupContentView];
    }
    return self;
}


/** 设置内容框 */
- (void)setupContentView
{
    self.flowLayout = [[XHWaterfallFlowLayout alloc] init];
    self.flowLayout.columnCount = 2;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.flowLayout.minimumInteritemSpacing = 10;
    self.flowLayout.minimumLineSpacing = 10;
    self.flowLayout.sDelegate = self;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, wh_screenWidth, ((wh_screenWidth - 30) * 0.75 + 10) * 5 + 10) collectionViewLayout:self.flowLayout];
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.scrollEnabled = NO;
    [self.collectionView registerClass:[OWCommodityItemCell class] forCellWithReuseIdentifier:ItemCellId];
    [self.contentView addSubview:self.collectionView];
}


#pragma mark - ---------- UICollectionViewDataSource ----------

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OWCommodityItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ItemCellId forIndexPath:indexPath];
    wh_weakSelf(self);
    cell.block = ^(){
        if (weakself.block) weakself.block();
    };
    return cell;
}


#pragma mark - ---------- XHWaterfallFlowLayoutDelegate ----------

- (CGFloat)getHeightExceptImageAtIndex:(NSIndexPath *)indexPath
{
    return (wh_screenWidth - 30) * 0.75;
}


@end
