//
//  OWSettingVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/16.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <SVProgressHUD.h>
#import "OWSettingVC.h"
#import "OWSettingCell.h"

@interface OWSettingVC ()

@property (nonatomic, assign) NSInteger cacheSize;
@property (nonatomic, strong) NSArray *optionList;

@end

@implementation OWSettingVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setValue:@1 forKeyPath:@"backgroundView.alpha"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"设置";
    
    [self setupTableView];
    [self getCacheSize];
}

/** 设置tableview */
- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = NO;
    
}

- (void)getCacheSize
{
    wh_weakSelf(self);
    [NSFileManager wh_getCacheSizeCompletion:^(NSInteger size) {
        weakself.cacheSize = size;
        
        weakself.optionList = @[
                            @{@"title":@"新消息通知", @"content":@""},
                            @{@"title":@"清理缓存", @"content":[NSString stringWithFormat:@"%.1fMB",(self.cacheSize/1024/1024.0)]},
                            @{@"title":@"关于", @"content":@""}
                            ];
        
        [weakself.tableView reloadData];
    }];
}


#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 47.0f;
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
    OWSettingCell *cell = [OWSettingCell cellWithTableView:tableView];
    cell.titleDic = self.optionList[indexPath.row];
    return cell;
}


#pragma mark - ---------- TableViewDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        [SVProgressHUD showWithStatus:@"正在清理..."];
        [NSFileManager wh_clearCache];
        wh_weakSelf(self);
        [SVProgressHUD dismissWithDelay:1.0 completion:^{
            [weakself getCacheSize];
        }];
    }
}

@end
