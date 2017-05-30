//
//  OWApprovalSearchResultVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/25.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWApprovalSearchResultVC.h"
#import "OWHomeApprovalCell.h"

@interface OWApprovalSearchResultVC ()

@end

@implementation OWApprovalSearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.resultList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWHomeApprovalCell *cell = [OWHomeApprovalCell cellWithTableView:tableView];
    return cell;
}


#pragma mark - ---------- TableViewDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
