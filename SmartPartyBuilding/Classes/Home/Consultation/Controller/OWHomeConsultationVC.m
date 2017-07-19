//
//  OWHomeConsultationVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/7/16.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "OWHomeConsultationVC.h"
#import "OWHomeConsultation.h"
#import "OWNetworking.h"
#import "OWHomeConsultationCell.h"
#import "OWHomeClnDetailVC.h"

@interface OWHomeConsultationVC ()

@property (nonatomic, strong) NSArray *consultationList;

@end

@implementation OWHomeConsultationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"互动咨询";
    self.tableView.separatorStyle = NO;
    [self dataRequest];
}



- (void)dataRequest
{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    NSDictionary *par = @{
                          @"isShadow":@(2)
                          };
    [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/discussion/getList") parameters:par success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            wh_Log(@"---%@",responseObject);
            self.consultationList = [OWHomeConsultation mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
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
    return self.consultationList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWHomeConsultationCell *cell = [OWHomeConsultationCell cellWithTableView:tableView];
    cell.consultation = self.consultationList[indexPath.row];
    return cell;
}


#pragma mark - ---------- TableViewDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OWHomeConsultation *consultation = self.consultationList[indexPath.row];
    OWHomeClnDetailVC *detailVC = [[OWHomeClnDetailVC alloc] init];
    detailVC.consultation = consultation;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
