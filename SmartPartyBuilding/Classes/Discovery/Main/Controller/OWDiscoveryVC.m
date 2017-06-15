//
//  OWDiscoveryVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/14.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWDiscoveryVC.h"
#import "OWDiscoveryPhotoCell.h"
#import "OWDiscoveryOptionCell.h"
#import "OWMomentsVC.h"
#import "OWDisDifPartyVC.h"
#import "OWDisOldPartyVC.h"
#import "OWDisVolVC.h"

@interface OWDiscoveryVC ()

@property (nonatomic, strong) NSArray *optionList;

@end

@implementation OWDiscoveryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"发现";
    
    [self setupTableView];
}

/** 设置tableview */
- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.optionList = @[
                        @{@"image" : @"discovery_moments", @"title" : @"光影", @"content" : @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495015108912&di=b42b24848b13a000b9d1539e8e395250&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201609%2F11%2F20160911103417_KRZJM.thumb.224_0.jpeg"},
                        @{@"image" : @"discovery_difficult", @"title" : @"困难党员", @"content" : @"加入"},
                        @{@"image" : @"discovery_old", @"title" : @"老党员", @"content" : @"加入"},
                        @{@"image" : @"discovery_donation", @"title" : @"志愿者", @"content" : @"加入"},
                        @{@"image" : @"discovery_score", @"title" : @"积分兑换", @"content" : @""}
                        ];
    
}

#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section == 1 ? 2 : 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
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
    
    if (indexPath.section == 0) {
        OWDiscoveryPhotoCell *cell = [OWDiscoveryPhotoCell cellWithTableView:tableView];
        cell.optionDic = self.optionList[indexPath.row];
        return cell;
    }else{
        OWDiscoveryOptionCell *cell = [OWDiscoveryOptionCell cellWithTableView:tableView];
        NSInteger idx = indexPath.section < 2 ? (indexPath.section + indexPath.row) : (indexPath.section + 1);
        cell.optionDic = self.optionList[idx];
        return cell;
    }
}


#pragma mark - ---------- TableViewDataDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        OWMomentsVC *momentsVC = [[OWMomentsVC alloc] init];
        [self.navigationController pushViewController:momentsVC animated:YES];
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            OWDisDifPartyVC *difPartyVC = [[OWDisDifPartyVC alloc] init];
            [self.navigationController pushViewController:difPartyVC animated:YES];
        }else{
            OWDisOldPartyVC *oldPartyVC = [[OWDisOldPartyVC alloc] init];
            [self.navigationController pushViewController:oldPartyVC animated:YES];
        }
    }else if (indexPath.section == 2){
        OWDisVolVC *volVC = [[OWDisVolVC alloc] init];
        [self.navigationController pushViewController:volVC animated:YES];
    }else{
        
    }
    
}

@end
