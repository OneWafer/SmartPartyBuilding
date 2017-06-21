//
//  OWMettingOrderVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/21.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <SVProgressHUD.h>
#import "OWMettingOrderVC.h"
#import "OWMeetingDateCell.h"
#import "OWMtOrderInputCell.h"
#import "OWMtSpecialNeedCell.h"
#import "OWMtAddDeviceCell.h"
#import "OWMtOrderDateCell.h"
#import "OWMtDatePickerView.h"
#import "OWMeeting.h"
#import "OWNetworking.h"

@interface OWMettingOrderVC ()

@property (nonatomic, weak) OWMtDatePickerView *dateView;
@property (nonatomic, strong) NSArray *titleList;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;

@end

@implementation OWMettingOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"预约";
    
    [self dataRequest];
    [self setupNavi];
    [self setupTableView];
}


/** 设置tableview */
- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.titleList = @[@"时间", @"会议内容", @"会议描述/主要参会人员"];
    self.startTime = [NSDate wh_getCurrentTimeWithFormat:@"yyyy-MM-dd HH:mm:ss"];
    self.endTime = [NSDate wh_getCurrentTimeWithFormat:@"yyyy-MM-dd HH:mm:ss"];
}

- (void)setupNavi
{
    wh_weakSelf(self);
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem wh_itemWithType:WHItemTypeRight norTitle:@"确认" font:15.0f norColor:wh_RGB(9, 131, 216) highColor:[UIColor blueColor] offset:0 actionHandler:^(UIButton *sender) {
        [weakself dataSubmit];
    }];
}

- (void)dataRequest
{
    NSDictionary *par = @{
                          @"type":@(2),
                          @"page":@"1",
                          @"rows":@"20"
                          };
    [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/facility/list") parameters:par success:^(id  _Nullable responseObject) {
        wh_Log(@"----%@",responseObject);
        if ([responseObject[@"code"] intValue] == 200) {
            
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
        wh_Log(@"---%@",error);
    }];
}

- (void)dataSubmit
{
    UITextView *contentTV = [self.view viewWithTag:1004];
    UITextView *peopleTV = [self.view viewWithTag:1006];
    NSDictionary *par = @{
                          @"roomId":@(self.meet.id),
                          @"startTime":self.startTime,
                          @"endTime":self.endTime,
                          @"content":contentTV.text,
                          @"people":peopleTV.text,
                          @"facility":@"电脑一台*4",
                          @"remark":@""
                          };
    wh_Log(@"---%@",par);
    [OWNetworking HPOST:wh_appendingStr(wh_host, @"mobile/meetingRoomOrder/apply") parameters:par success:^(id  _Nullable responseObject) {
        wh_Log(@"----%@",responseObject);
        if ([responseObject[@"code"] intValue] == 200) {
            [SVProgressHUD showSuccessWithStatus:@"预约成功!"];
            [self.navigationController popViewControllerAnimated:YES];
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
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4) {
        return 45.0f;
    }else if (indexPath.row == 3 || indexPath.row == 5){
        return 100.0f;
    }else if (indexPath.row == 6 || indexPath.row == 7){
        return 70.0f;
    }else{
        return 50.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    wh_weakSelf(self);
    if (indexPath.row == 0 || indexPath.row == 2 || indexPath.row == 4) {
        OWMeetingDateCell *cell = [OWMeetingDateCell cellWithTableView:tableView];
        cell.title = self.titleList[indexPath.row/2];
        return cell;
    }else if (indexPath.row == 1){
        OWMtOrderDateCell *cell = [OWMtOrderDateCell cellWithTableView:tableView];
        __weak OWMtOrderDateCell *weakCell = cell;
        cell.block = ^(NSInteger tag){
            [weakself datePick:weakCell Tag:tag];
        };
        return cell;
    }else if (indexPath.row == 3 || indexPath.row == 5){
        OWMtOrderInputCell *cell = [OWMtOrderInputCell cellWithTableView:tableView];
        cell.placeStr = (indexPath.row == 3) ? @"输入内容" : @"描述";
        cell.inputView.tag = indexPath.row + 1001;
        return cell;
    }else if (indexPath.row == 6){
        OWMtSpecialNeedCell *cell = [OWMtSpecialNeedCell cellWithTableView:tableView];
        return cell;
    }else{
        OWMtAddDeviceCell *cell = [OWMtAddDeviceCell cellWithTableView:tableView];
        cell.title = @"添加设施";
        return cell;
    }
    
}

- (void)datePick:(OWMtOrderDateCell *)cell Tag:(NSInteger)tag
{
    wh_weakSelf(self);
    weakself.dateView.blcok = ^(NSDate *date){
        if (tag == 11) {
            cell.startLabel.text = [date wh_getDateStringWithFormat:@"yyyy-MM-dd HH:mm"];
            self.startTime = [date wh_getDateStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
        }else{
            cell.endLabel.text = [date wh_getDateStringWithFormat:@"yyyy-MM-dd HH:mm"];
            self.endTime = [date wh_getDateStringWithFormat:@"yyyy-MM-dd HH:mm:ss"];
        }
    };
    [weakself.dateView fadeIn];
}


#pragma mark - ---------- Lazy ----------

- (OWMtDatePickerView *)dateView
{
    if (!_dateView) {
        OWMtDatePickerView *view = [[OWMtDatePickerView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        view.chooseTimeLabel.text = @"请选择时间";
        [self.view.window addSubview:view];
        _dateView = view;
    }
    return _dateView;
}

@end
