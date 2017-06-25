//
//  OWLoginBranchVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//


#import "OWLoginBranchVC.h"
#import "OWBranchSearchResultVC.h"
#import "OWChineseSort.h"
#import "OWLoginBranchCell.h"
#import "OWBranch.h"

@interface OWLoginBranchVC ()<UISearchBarDelegate,UISearchResultsUpdating>

@property(nonatomic,strong) UISearchController *searchVC;
@property(nonatomic,strong) OWBranchSearchResultVC *resultVC;
//排序后的出现过的拼音首字母数组
@property(nonatomic,strong)NSMutableArray *indexArray;
//排序好的结果数组
@property(nonatomic,strong)NSMutableArray *letterResultArr;

@end

@implementation OWLoginBranchVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置背景透明图片
    [self.navigationController.navigationBar setValue:@1 forKeyPath:@"backgroundView.alpha"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"支部列表";
    self.tableView.separatorStyle = NO;
    
    //根据Person对象的 name 属性 按中文 对 Person数组 排序
    self.indexArray = [OWChineseSort IndexWithArray:self.branchList Key:@"organizationName"];
    self.letterResultArr = [OWChineseSort sortObjectArray:self.branchList Key:@"organizationName"];
    
    [self setupSearchBar];
}




- (void)setupSearchBar
{
    self.resultVC = [[OWBranchSearchResultVC alloc] init];
    self.resultVC.mainSearchController = self;
    self.searchVC = [[UISearchController alloc]initWithSearchResultsController:self.resultVC];
    self.resultVC.tableView.delegate = self;
    [self.searchVC.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchVC.searchBar;
    //设置搜索控制器的结果更新代理对象
    self.searchVC.searchResultsUpdater=self;
    //为了响应scope改变时候，对选中的scope进行处理 需要设置search代理
    self.searchVC.searchBar.delegate=self;
    self.definesPresentationContext=YES;   //迷之属性，打开后搜索结果页界面显示会比较好
}



#pragma mark - ---------- TableViewDataSource ----------

//section的titleHeader
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.indexArray[section];
}
//section行数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.indexArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.letterResultArr[section] count];
}

//section右侧index数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.indexArray;
}

//点击右侧索引表项时调用 索引与section的对应关系
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    return index;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWLoginBranchCell *cell = [OWLoginBranchCell cellWithTableView:tableView];
    OWBranch *branch = self.letterResultArr[indexPath.section][indexPath.row];
    cell.title = branch.organizationName;
    return cell;
}


#pragma mark - ---------- TableViewDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWBranch *branch = self.letterResultArr[indexPath.section][indexPath.row];
    if (self.block) self.block(branch);
    [self.navigationController popViewControllerAnimated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - ---------- UISearchResultsUpdating ----------

/**实现更新代理*/
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    //获取到用户输入的数据
    NSString *searchText=searchController.searchBar.text;
    wh_Log(@"------%@",searchText);
    NSMutableArray *resultList=[NSMutableArray array];
    for (OWBranch *b in self.branchList) {
        NSRange range=[b.organizationName rangeOfString:searchText];
        if (range.length>0) {
            [resultList addObject:b];
        }
    }
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

@end
