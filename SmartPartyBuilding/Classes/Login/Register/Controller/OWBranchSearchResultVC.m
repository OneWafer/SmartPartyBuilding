//
//  OWBranchSearchResultVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWBranchSearchResultVC.h"
#import "OWLoginBranchCell.h"
#import "OWBranch.h"

@interface OWBranchSearchResultVC ()

@end

@implementation OWBranchSearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = NO;
}


#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWLoginBranchCell *cell = [OWLoginBranchCell cellWithTableView:tableView];
    OWBranch *branch = self.resultList[indexPath.row];
    cell.title = branch.organizationName;
    return cell;
}


#pragma mark - ---------- TableViewDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
