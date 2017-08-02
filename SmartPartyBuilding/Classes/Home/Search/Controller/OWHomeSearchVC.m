//
//  OWHomeSearchVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/7/29.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <MJExtension.h>
#import <ReactiveCocoa.h>
#import <SVProgressHUD.h>
#import "OWHomeSearchVC.h"
#import "OWNetworking.h"
#import "OWNews.h"
#import "OWHomeNewsCell.h"
#import "OWNewsDetailVC.h"

@interface OWHomeSearchVC ()

@property (nonatomic, weak) UITextField *searchTF;
@property (nonatomic, strong) NSArray *resultList;

@end

@implementation OWHomeSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = NO;
    
    [self setupSearchView];
}

/** 设置searchView */
- (void)setupSearchView
{
    wh_weakSelf(self);
    [self.searchTF becomeFirstResponder];
    [self.searchTF.rac_textSignal subscribeNext:^(NSString *x) {
        if (x.length) [weakself dataRequest:x];
    }];
}

/** 请求订单数据 */
- (void)dataRequest:(NSString *)keyword
{
    NSDictionary *par = @{
                          @"title":keyword
                          };
    wh_Log(@"--%@",par);
    [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/appset/getSearchInfo") parameters:par success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            wh_Log(@"==%@",responseObject);
            _resultList = [OWNews mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"newsList"]];
            [self.tableView reloadData];
            //            [SVProgressHUD dismiss];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络"];
    }];
}

#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWHomeNewsCell *cell = [OWHomeNewsCell cellWithTableView:tableView];
    cell.news = _resultList[indexPath.row];
    return cell;
}

#pragma mark - ---------- TableViewDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
        OWNewsDetailVC *newsVC = [[OWNewsDetailVC alloc] init];
        newsVC.news = self.resultList[indexPath.row - 1];
        [self.navigationController pushViewController:newsVC animated:YES];
}


#pragma mark - ---------- lazy ----------

- (UITextField *)searchTF
{
    if (_searchTF == nil) {
        UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, wh_screenWidth * 0.7, 35)];
        //        tf.backgroundColor = [UIColor whiteColor];
        tf.borderStyle = UITextBorderStyleRoundedRect;
        //        tf.tintColor = wh_themeColor;
        self.navigationItem.titleView = tf;
        _searchTF = tf;
    }
    return _searchTF;
}


@end
