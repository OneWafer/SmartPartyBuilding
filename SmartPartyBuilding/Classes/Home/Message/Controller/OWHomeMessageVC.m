//
//  OWHomeMessageVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/7/2.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "OWHomeMessageVC.h"
#import "OWNetworking.h"
#import "OWHomeMessageCell.h"
#import "OWHomeMessage.h"

@interface OWHomeMessageVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UIView *sltView;
@property (nonatomic, weak) UIButton *alreadyBtn;
@property (nonatomic, weak) UIButton *unreadBtn;
@property (nonatomic, weak) UITableView *myTableView;
@property (nonatomic, strong) NSArray *messageList;

@end

@implementation OWHomeMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.title = @"消息";
    [self setupSltView];
    [self setupTableView];
    [self dataRequest];
}


- (void)setupSltView
{
    wh_weakSelf(self);
    [self.alreadyBtn wh_addActionHandler:^(UIButton *sender) {
        if (sender.selected) return;
        sender.selected = YES;
        weakself.unreadBtn.selected = NO;
        [weakself dataRequest];
    }];
    
    [self.unreadBtn wh_addActionHandler:^(UIButton *sender) {
        if (sender.selected) return;
        sender.selected = YES;
        weakself.alreadyBtn.selected = NO;
        [weakself dataRequest];
    }];
}

- (void)setupTableView
{
    self.myTableView.separatorStyle = NO;
}

- (void)dataRequest
{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    NSDictionary *par = @{
                          @"isRead":@(self.alreadyBtn.selected)
                          };
    [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/message/getSysMessages") parameters:par success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            wh_Log(@"---%@",responseObject);
            self.messageList = [OWHomeMessage mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.myTableView reloadData];
            [SVProgressHUD dismiss];
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
    return self.messageList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWHomeMessageCell *cell = [OWHomeMessageCell cellWithTableView:tableView];
    cell.message = self.messageList[indexPath.row];
    return cell;
}


#pragma mark - ---------- TableViewDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWHomeMessage *message = self.messageList[indexPath.row];
//    OWNoticeDetailVC *detailVC = [[OWNoticeDetailVC alloc] init];
//    detailVC.notice = notice;
//    [self.navigationController pushViewController:detailVC animated:YES];
}


#pragma mark - ---------- Lazy ----------

- (UIView *)sltView
{
    if (!_sltView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = wh_RGB(240, 240, 240);
        [self.view addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(64);
            make.height.equalTo(45);
        }];
        
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = wh_lineColor;
        [view addSubview:lineView];
        
        [lineView makeConstraints:^(MASConstraintMaker *make) {
            make.center.height.equalTo(view);
        }];
        _sltView = view;
    }
    return _sltView;
}


- (UIButton *)unreadBtn
{
    if (!_unreadBtn) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:@"未读" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.5f];
        btn.selected = YES;
        [btn setTitleColor:wh_RGB(159, 159, 159) forState:UIControlStateNormal];
        [btn setTitleColor:wh_norFontColor forState:UIControlStateSelected];
        [self.sltView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.equalTo(self.sltView);
            make.width.equalTo(self.sltView).multipliedBy(0.5);
        }];
        _unreadBtn = btn;
    }
    return _unreadBtn;
}


- (UIButton *)alreadyBtn
{
    if (!_alreadyBtn) {
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:@"已读" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14.5f];
        [btn setTitleColor:wh_RGB(159, 159, 159) forState:UIControlStateNormal];
        [btn setTitleColor:wh_norFontColor forState:UIControlStateSelected];
        [self.sltView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.equalTo(self.sltView);
            make.width.equalTo(self.sltView).multipliedBy(0.5);
        }];
        _alreadyBtn = btn;
    }
    return _alreadyBtn;
}


- (UITableView *)myTableView
{
    if (!_myTableView) {
        UITableView *tableView = [[UITableView alloc] init];
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:tableView];
        
        [tableView makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.top.equalTo(self.sltView.bottom);
        }];
        _myTableView = tableView;
    }
    return _myTableView;
}

@end
