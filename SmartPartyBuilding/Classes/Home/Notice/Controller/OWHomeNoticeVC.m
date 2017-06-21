//
//  OWHomeNoticeVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/23.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "OWHomeNoticeVC.h"
#import "OWNoticeSearchResultVC.h"
#import "OWHomeNoticeCell.h"
#import "OWNetworking.h"
#import "OWMessage.h"

@interface OWHomeNoticeVC ()<UISearchBarDelegate,UISearchResultsUpdating>

@property(nonatomic,strong) UISearchController *searchVC;
@property(nonatomic,strong) OWNoticeSearchResultVC *resultVC;
@property (nonatomic, strong) NSArray *messageList;

@end

@implementation OWHomeNoticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"通知公告";
    self.tableView.separatorStyle = NO;
    
    [self setupSearchBar];
    [self dataRequest];
}

- (void)setupSearchBar
{
    self.resultVC = [[OWNoticeSearchResultVC alloc] init];
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
    [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/message/getMessages") parameters:nil success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            wh_Log(@"---%@",responseObject);
            self.messageList = [OWMessage mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
    }];
}


#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWHomeNoticeCell *cell = [OWHomeNoticeCell cellWithTableView:tableView];
    cell.message = self.messageList[indexPath.row];
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
    for (OWMessage *m in self.messageList) {
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
