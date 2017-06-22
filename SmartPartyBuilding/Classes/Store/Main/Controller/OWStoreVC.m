//
//  OWStoreVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/20.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <ReactiveCocoa.h>
#import "OWStoreVC.h"
#import "OWStoreItemCell.h"
#import "OWItemDetailsVC.h"
#import "OWNetworking.h"
#import "OWRefreshGifHeader.h"
#import "OWStoreHeaderView.h"
#import "OWStoreSectionHeaderView.h"
#import "OWBanner.h"
#import "OWStoreItem.h"

@interface OWStoreVC ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *hotList;
@property (nonatomic, strong) NSArray *bannerList;
@property (nonatomic, strong) NSArray *allList;
@property (nonatomic, strong) OWStoreHeaderView *headerView;
@end

@implementation OWStoreVC

static NSString * const ItemCellId = @"OWStoreItemCellId";
static NSString *const identifier = @"OWStoreItemCell";
static NSString *const headerId0 = @"headerId0";
static NSString *const headerId1 = @"headerId1";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"积分商城";
    [self setupContentView];
    [self setupRefresh];
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
    [self.collectionView registerClass:[OWStoreHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId0];
    [self.collectionView registerClass:[OWStoreSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId1];
    [self.view addSubview:self.collectionView];
}

- (void)setupRefresh
{
    wh_weakSelf(self);
    self.collectionView.mj_header = [OWRefreshGifHeader headerWithRefreshingBlock:^{
        [weakself dataRequest];
    }];
    [self.collectionView.mj_header beginRefreshing];
}

/** 数据请求 */
- (void)dataRequest
{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    
    RACSignal *hotRequest = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
    
        [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/item/integralMall") parameters:nil success:^(id  _Nullable responseObject) {
//            wh_Log(@"%@",responseObject);
            if ([responseObject[@"code"] intValue] == 200) {
                [subscriber sendNext:responseObject[@"data"]];
                
            }else{
                [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
                [self.collectionView.mj_header endRefreshing];
            }
        } failure:^(NSError * _Nonnull error) {
            [self.collectionView.mj_header endRefreshing];
            [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
        }];
        
        return nil;
    }];
    
    RACSignal *allRequest = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/item/list") parameters:nil success:^(id  _Nullable responseObject) {
            wh_Log(@"%@",responseObject);
            if ([responseObject[@"code"] intValue] == 200) {
                self.allList = [OWStoreItem mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                [subscriber sendNext:self.allList];
            }else{
                [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
                [self.collectionView.mj_header endRefreshing];
            }
        } failure:^(NSError * _Nonnull error) {
            [self.collectionView.mj_header endRefreshing];
            [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
            wh_Log(@"---%@",error);
        }];
        
        return nil;
    }];
    
    // 使用注意：几个信号，参数一的方法就几个参数，每个参数对应信号发出的数据。
    [self rac_liftSelector:@selector(updateUIWithR1:r2:) withSignalsFromArray:@[hotRequest, allRequest]];
    
}

// 更新UI
- (void)updateUIWithR1:(id)hotDic r2:allList
{
    [SVProgressHUD dismiss];
    [self.collectionView.mj_header endRefreshing];
    
    self.bannerList = [OWBanner mj_objectArrayWithKeyValuesArray:hotDic[@"picList"]];
    self.hotList = [OWStoreItem mj_objectArrayWithKeyValuesArray:hotDic[@"hotList"]];
    
    // 取出banner图片数组
    NSMutableArray *banImgList = [NSMutableArray array];
    [self.bannerList wh_each:^(OWBanner *obj) {
        [banImgList addObject:obj.url];
    }];
    
    self.headerView.infoDic = @{
                                @"banner":banImgList,
                                @"score":hotDic[@"integral"]
                                };
    
    [allList wh_each:^(OWStoreItem *obj) {
        wh_Log(@"---%@--%d",obj.itemName, obj.num);
    }];
    [self.collectionView reloadData];
}

#pragma mark - ---------- UICollectionViewDataSource ----------

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return section ? self.allList.count : self.hotList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    OWStoreItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ItemCellId forIndexPath:indexPath];
    if (indexPath.section == 0) {
        cell.item = self.hotList[indexPath.row];
    }else{
        cell.item = self.allList[indexPath.row];
    }
    return cell;
}

// 设置section头视图的参考大小，与tableheaderview类似
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, section ? 35.0f : 253.0f);
}

// 和UITableView类似，UICollectionView也可设置段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        if (indexPath.section) {
            OWStoreSectionHeaderView *headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId1 forIndexPath:indexPath];
            return headerView;
        }else{
            self.headerView = [_collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerId0 forIndexPath:indexPath];
            return self.headerView;
        }
        
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


#pragma mark - ---------- Lazy ----------



@end
