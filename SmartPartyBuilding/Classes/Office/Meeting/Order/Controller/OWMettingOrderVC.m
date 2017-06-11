//
//  OWMettingOrderVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/21.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWMettingOrderVC.h"
#import "OWMeetingDateCell.h"
#import "OWMtOrderInputCell.h"
#import "OWMtSpecialNeedCell.h"
#import "OWMtAddDeviceCell.h"
#import "OWMtOrderDateCell.h"
#import "OWMtDatePickerView.h"

@interface OWMettingOrderVC ()

@property (nonatomic, weak) OWMtDatePickerView *dateView;
@property (nonatomic, strong) NSArray *titleList;

@end

@implementation OWMettingOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"预约";
    
    [self setupTableView];
}


/** 设置tableview */
- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    //    self.tableView.backgroundColor = wh_RGB(244, 245, 246);
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.titleList = @[@"时间", @"会议内容", @"会议描述/主要参会人员"];
}

- (void)setupNavi
{
    wh_weakSelf(self);
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem wh_itemWithType:WHItemTypeRight norTitle:@"完成" font:14 norColor:wh_RGB(9, 131, 216) highColor:[UIColor blueColor] offset:0 actionHandler:^(UIButton *sender) {
        wh_Log(@"---点击了完成");
    }];
}


#pragma mark - ---------- TableViewDataSource ----------

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 0;
//}

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
        return 60.0f;
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
        return cell;
    }else if (indexPath.row == 6){
        OWMtSpecialNeedCell *cell = [OWMtSpecialNeedCell cellWithTableView:tableView];
        return cell;
    }else{
        OWMtAddDeviceCell *cell = [OWMtAddDeviceCell cellWithTableView:tableView];
        return cell;
    }
    
}

- (void)datePick:(OWMtOrderDateCell *)cell Tag:(NSInteger)tag
{
    wh_weakSelf(self);
    weakself.dateView.blcok = ^(NSDate *date){
        if (tag == 11) {
            cell.startLabel.text = [date wh_getDateStringWithFormat:@"yyyy-MM-dd HH:mm"];
        }else{
            cell.endLabel.text = [date wh_getDateStringWithFormat:@"yyyy-MM-dd HH:mm"];
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
        [self.view addSubview:view];
        _dateView = view;
    }
    return _dateView;
}

@end
