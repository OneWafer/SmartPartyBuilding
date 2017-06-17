//
//  OWExcPartyMemberVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/16.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "OWExcPartyMemberVC.h"
#import "OWEPMSearchResultVC.h"
#import "OWExcPartyMemCell.h"
#import "OWExcPartyMember.h"
#import "OWNetworking.h"

@interface OWExcPartyMemberVC ()<UISearchBarDelegate,UISearchResultsUpdating>

@property(nonatomic,strong) UISearchController *searchVC;
@property(nonatomic,strong) OWEPMSearchResultVC *resultVC;
@property (nonatomic, strong) NSArray *memberList;

@end

@implementation OWExcPartyMemberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = NO;
    
    self.navigationItem.title = @"优秀党员";
    [self setupSearchBar];
    [self dataRequest];
}

- (void)setupSearchBar
{
    self.resultVC = [[OWEPMSearchResultVC alloc] init];
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


- (void)dataRequest
{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/excellentMember/list") parameters:nil success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            wh_Log(@"---%@",responseObject);
            self.memberList = [OWExcPartyMember mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
    }];
}


#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.memberList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWExcPartyMemCell *cell = [OWExcPartyMemCell cellWithTableView:tableView];
    cell.member = self.memberList[indexPath.row];
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
    //获取到用户输入的数据
    NSString *searchText=searchController.searchBar.text;
    wh_Log(@"------%@",searchText);
    NSMutableArray *resultList=[NSMutableArray array];
    for (OWExcPartyMember *m in self.memberList) {
        NSRange range=[m.title rangeOfString:searchText];
        if (range.length>0) {
            [resultList addObject:m];
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


#pragma mark - ---------- Lazy ----------





@end
