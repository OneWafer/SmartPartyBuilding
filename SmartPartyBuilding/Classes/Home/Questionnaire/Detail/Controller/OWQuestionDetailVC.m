//
//  OWQuestionDetailVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "OWQuestionDetailVC.h"
#import "OWQuestionTitleCell.h"
#import "OWQuestionItemCell.h"
#import "OWNetworking.h"
#import "OWQuestionnaire.h"
#import "OWQuestion.h"
#import "OWQuestionItem.h"
#import "OWQuestionSubmitCell.h"

@interface OWQuestionDetailVC ()

@property (nonatomic, strong) NSArray *questionList;

@end

@implementation OWQuestionDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"问卷详情";
    [self setupTableView];
    [self dataRequest];
}

/** 设置tableview */
- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)dataRequest
{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    NSDictionary *par = @{
                          @"researchId":@(self.questionnaire.id)
                          };
    [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/exam/getPaper") parameters:par success:^(id  _Nullable responseObject) {
        wh_Log(@"---%@",responseObject);
        if ([responseObject[@"code"] intValue] == 200) {
            self.questionList = [OWQuestion mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.tableView reloadData];
            [SVProgressHUD dismiss];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
    }];
}


- (void)submitAnswer
{
    [SVProgressHUD showWithStatus:@"正在提交..."];
    
    NSArray *answerList = [self.questionList wh_map:^id(OWQuestion *obj) {
        OWQuestionItem *item = obj.items[obj.idx.row - 1];
        NSDictionary *dic = @{
                              @"id":@(obj.id),
                              @"researchId":@(obj.researchId),
                              @"questionId":@(obj.questionId),
                              @"answer_id":@(item.id)
                              };
        return dic;
    }];
    
    NSDictionary *par = @{
                          @"answer":answerList
                          };
    wh_Log(@"---%@",par);
    
    [OWNetworking HPOST:wh_appendingStr(wh_host, @"mobile/exam/postAnswer") parameters:par success:^(id  _Nullable responseObject) {
        wh_Log(@"---%@",responseObject);
        if ([responseObject[@"code"] intValue] == 200) {
            
            [SVProgressHUD showSuccessWithStatus:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
    }];
}


#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.questionList.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section < self.questionList.count) {
        OWQuestion *question = self.questionList[section];
        return question.items.count + 1;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < self.questionList.count) {
        return indexPath.row ? 45.0f : 40.0f;
    }else{
        return 100.0f;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < self.questionList.count) {
        OWQuestion *question = self.questionList[indexPath.section];
        if (indexPath.row == 0) {
            OWQuestionTitleCell *cell = [OWQuestionTitleCell cellWithTableView:tableView];
            cell.question = question;
            return cell;
        }else{
            OWQuestionItemCell *cell = [OWQuestionItemCell cellWithTableView:tableView];
            cell.item = question.items[indexPath.row - 1];
            return cell;
        }
    }else{
        wh_weakSelf(self);
        OWQuestionSubmitCell *cell = [OWQuestionSubmitCell cellWithTableView:tableView];
        cell.block = ^(){
            [weakself submitAnswer];
        };
        return cell;
    }
    
}


#pragma mark - ---------- TableViewDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section < self.questionList.count) {
        
        OWQuestion *question = self.questionList[indexPath.section];
        
        if (question.idx.row > 0) {
            OWQuestionItemCell *cell = [self.tableView cellForRowAtIndexPath:question.idx];
            cell.sltImgView.image = wh_imageNamed(@"office_cmd_radio");
        }
        question.idx = indexPath;
        OWQuestionItemCell *cell = [self.tableView cellForRowAtIndexPath:question.idx];
        cell.sltImgView.image = wh_imageNamed(@"office_cmd_radio_slt");
    }
}

@end
