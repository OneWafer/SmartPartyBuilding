//
//  OWUserInfoVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/16.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWUserInfoVC.h"
#import "OWUserInfoCell.h"
#import "OWUserInfoAvatarCell.h"

@interface OWUserInfoVC ()

@property (nonatomic, strong) NSArray *optionList;

@end

@implementation OWUserInfoVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setValue:@1 forKeyPath:@"backgroundView.alpha"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"资料管理";
    [self setupTableView];
}

/** 设置tableview */
- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.optionList = @[
                        @{@"title" : @"头像", @"content" : @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495013878561&di=dd51021a1b7cd2a0efa281056ac961fa&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201603%2F04%2F20160304174443_42UTn.thumb.224_0.jpeg"},
                        @{@"title" : @"名字", @"content" : @"张三丰"},
                        @{@"title" : @"性别", @"content" : @"男"},
                        @{@"title" : @"个性签名", @"content" : @"我爱学习，学习使我快乐!"},
                        @{@"title" : @"我的地址", @"content" : @"江苏省无锡市"},
                        ];
}

#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section ? 2 : 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.section == 0 && indexPath.row == 0) ? 80.0f : 45.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.row == 0) {
        OWUserInfoAvatarCell *cell = [OWUserInfoAvatarCell cellWithTableView:tableView];
        cell.optionDic = self.optionList[indexPath.row];
        return cell;
    }else{
        OWUserInfoCell *cell = [OWUserInfoCell cellWithTableView:tableView];
        cell.optionDic = self.optionList[indexPath.row + indexPath.section * 3];
        return cell;
    }
}



@end