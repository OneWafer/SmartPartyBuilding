//
//  OWNoticeSearchResultVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/23.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWNoticeSearchResultVC.h"
#import "OWHomeActivityCell.h"

@interface OWNoticeSearchResultVC ()

@end

@implementation OWNoticeSearchResultVC

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
    OWHomeActivityCell *cell = [OWHomeActivityCell cellWithTableView:tableView];
    return cell;
}


#pragma mark - ---------- TableViewDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
