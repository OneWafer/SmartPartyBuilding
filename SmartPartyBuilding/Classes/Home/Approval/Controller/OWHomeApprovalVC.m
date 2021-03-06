//
//  OWHomeApprovalVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/25.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWHomeApprovalVC.h"
#import "OWApprovalSearchResultVC.h"
#import "OWHomeApprovalCell.h"

@interface OWHomeApprovalVC ()<UISearchBarDelegate,UISearchResultsUpdating>

@property(nonatomic,strong) UISearchController *searchVC;
@property(nonatomic,strong) OWApprovalSearchResultVC *resultVC;

@end

@implementation OWHomeApprovalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"公文审批";
    
    [self setupSearchBar];
}

- (void)setupSearchBar
{
    self.resultVC = [[OWApprovalSearchResultVC alloc] init];
    self.resultVC.mainSearchController = self;
    self.searchVC = [[UISearchController alloc]initWithSearchResultsController:self.resultVC];
    [self.searchVC.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchVC.searchBar;
    //设置搜索控制器的结果更新代理对象
    self.searchVC.searchResultsUpdater=self;
    //为了响应scope改变时候，对选中的scope进行处理 需要设置search代理
    self.searchVC.searchBar.delegate=self;
    self.definesPresentationContext=YES;   //迷之属性，打开后搜索结果页界面显示会比较好
}


#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWHomeApprovalCell *cell = [OWHomeApprovalCell cellWithTableView:tableView];
    return cell;
}


#pragma mark - ---------- TableViewDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - ---------- UISearchResultsUpdating ----------

/**实现更新代理*/
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    //获取scope被选中的下标
    NSInteger selectedType=searchController.searchBar.selectedScopeButtonIndex;
    //获取到用户输入的数据
    NSString *searchText=searchController.searchBar.text;
    NSMutableArray *resultList=[NSMutableArray array];
    //    for (Product *p in self.allProducts) {
    //        NSRange range=[p.name rangeOfString:searchText];
    //        if (range.length>0 && p.type==selectedType) {
    //            [searchResult addObject:p];
    //        }
    //    }
    self.resultVC.resultList=resultList;
    
    /**通知结果ViewController进行更新*/
    [self.resultVC.tableView reloadData];
}


#pragma mark - ---------- UISearchBarDelegate ----------

/**点击按钮后，进行搜索页更新*/
-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    [self updateSearchResultsForSearchController:self.searchVC];
}


#pragma mark - ---------- Lazy ----------

@end
