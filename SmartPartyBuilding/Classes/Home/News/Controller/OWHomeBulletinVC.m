//
//  OWHomeBulletinVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/7/1.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWHomeBulletinVC.h"
#import "OWNewsDetailVC.h"
#import "OWHomeNewsCell.h"
#import "OWNews.h"

@interface OWHomeBulletinVC ()

@end

@implementation OWHomeBulletinVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"党建快报";
    self.tableView.separatorStyle = NO;
}

#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.bulletinList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWHomeNewsCell *cell = [OWHomeNewsCell cellWithTableView:tableView];
    cell.news = self.bulletinList[indexPath.row];
    return cell;
}


#pragma mark - ---------- TableViewDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWNews *news = self.bulletinList[indexPath.row];
    OWNewsDetailVC *detailVC = [[OWNewsDetailVC alloc] init];
    detailVC.news = news;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
