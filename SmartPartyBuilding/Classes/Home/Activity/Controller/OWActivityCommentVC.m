//
//  OWActivityCommentVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/7/1.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "OWActivityCommentVC.h"
#import "OWHomeCommentCell.h"
#import "OWMsgComment.h"
#import "OWNetworking.h"
#import "OWHomeActivity.h"

@interface OWActivityCommentVC ()

@property (nonatomic, strong) NSArray *commentList;

@end

@implementation OWActivityCommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"评论";
    self.tableView.separatorStyle = NO;
    [self dataRequest];
}

- (void)dataRequest
{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    NSDictionary *par = @{
                          @"articleId":@(self.activity.id),
                          @"articleType":@(7)
                          };
    [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/reply/replyList") parameters:par success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            wh_Log(@"---%@",responseObject);
            self.commentList = [OWMsgComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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
    return self.commentList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWHomeCommentCell *cell = [OWHomeCommentCell cellWithTableView:tableView];
    cell.comment = self.commentList[indexPath.row];
    return cell;
}


#pragma mark - ---------- TableViewDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWMsgComment *comment = self.commentList[indexPath.row];
    //    OWNoticeDetailVC *detailVC = [[OWNoticeDetailVC alloc] init];
    //    detailVC.message = message;
    //    [self.navigationController pushViewController:detailVC animated:YES];
}


@end
