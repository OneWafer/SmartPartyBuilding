//
//  OWStoreVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/20.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWStoreVC.h"
#import "OWStoreItemCell.h"
#import "OWItemDetailsVC.h"

@interface OWStoreVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation OWStoreVC

static NSString * const ItemCellId = @"OWStoreItemCellId";
static NSString *const identifier = @"OWStoreItemCell";
static NSString *const headerId = @"headerId";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"积分商城";
    [self setupContentView];
}



/** 设置内容框 */
- (void)setupContentView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[OWStoreItemCell class] forCellWithReuseIdentifier:ItemCellId];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
    [self.view addSubview:self.collectionView];
}


#pragma mark - ---------- UICollectionViewDataSource ----------

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OWStoreItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ItemCellId forIndexPath:indexPath];
    return cell;
}

// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, 35);
}

// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId forIndexPath:indexPath];

        [headerView.subviews wh_apply:^(UIView *obj) {
            [obj removeFromSuperview];
        }];
        headerView.backgroundColor = wh_RGB(241, 241, 241);
        
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.text = indexPath.section ? @"所有兑换" : @"热门兑换";
        titleLabel.textColor = wh_norFontColor;
        titleLabel.font = [UIFont systemFontOfSize:14.5f];
        [headerView addSubview:titleLabel];
        [titleLabel makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(headerView);
        }];
        
        UIView *lineView1 = [[UIView alloc] init];
        lineView1.backgroundColor = wh_lineColor;
        [headerView addSubview:lineView1];
        [lineView1 makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(headerView);
            make.left.equalTo(headerView).offset(15);
            make.right.equalTo(titleLabel.left).offset(-15);
            make.height.equalTo(0.5);
        }];
        
        UIView *lineView2 = [[UIView alloc] init];
        lineView2.backgroundColor = wh_lineColor;
        [headerView addSubview:lineView2];
        [lineView2 makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(headerView);
            make.right.equalTo(headerView).offset(-15);
            make.left.equalTo(titleLabel.right).offset(15);
            make.height.equalTo(0.5);
        }];
        
        return headerView;
    }
    
    return nil;
}


#pragma mark - ---------- UICollectionViewDelegate ----------

//UICollectionView被选中的时候调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",indexPath);
    OWItemDetailsVC *detailVC = [[OWItemDetailsVC alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark - ---------- UICollectionViewDelegateFlowLayout ----------

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((wh_screenWidth - 30 ) * 0.5, (wh_screenWidth - 30 ) * 0.7);
}

// 设置每个cell上下左右相距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

// 设置最小行间距，也就是前一行与后一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}

// 设置最小列间距，也就是左行与右一行的中间最小间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}


@end
