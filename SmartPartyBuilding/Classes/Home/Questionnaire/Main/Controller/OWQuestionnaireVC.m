//
//  OWQuestionnaireVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/16.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "OWQuestionnaireVC.h"
#import "OWQuestionDetailVC.h"
#import "OWQuestionnaireCell.h"
#import "OWNetworking.h"
#import "OWQuestionnaire.h"

@interface OWQuestionnaireVC ()

@property (nonatomic, strong) NSArray *questionList;

@end

@implementation OWQuestionnaireVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"调查问卷";
    
    [self setupTableView];
    [self dataRequest];
}

/** 设置tableview */
- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 47.0f;
}


- (void)dataRequest
{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    NSDictionary *par = @{
                          @"status":@(1)
                          };
    [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/exam/getResearch") parameters:par success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            self.questionList = [OWQuestionnaire mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [SVProgressHUD dismiss];
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
        wh_Log(@"---%@",error);
    }];
}


#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.questionList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWQuestionnaireCell *cell = [OWQuestionnaireCell cellWithTableView:tableView];
    cell.questionnaire = self.questionList[indexPath.row];
    return cell;
}


#pragma mark - ---------- TableViewDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWQuestionDetailVC *qdVC = [[OWQuestionDetailVC alloc] init];
    qdVC.questionnaire = self.questionList[indexPath.row];
    [self.navigationController pushViewController:qdVC animated:YES];
}

@end
