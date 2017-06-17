//
//  OWEPMSearchResultVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/16.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWEPMSearchResultVC.h"
#import "OWExcPartyMemCell.h"
#import "OWExcPartyMember.h"

@interface OWEPMSearchResultVC ()

@end

@implementation OWEPMSearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = NO;
}

#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultList.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWExcPartyMemCell *cell = [OWExcPartyMemCell cellWithTableView:tableView];
    cell.member = self.resultList[indexPath.row];
    return cell;
}


#pragma mark - ---------- TableViewDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
