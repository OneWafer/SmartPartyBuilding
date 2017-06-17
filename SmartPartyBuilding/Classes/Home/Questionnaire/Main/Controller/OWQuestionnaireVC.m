//
//  OWQuestionnaireVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/16.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <SVProgressHUD.h>
#import "OWQuestionnaireVC.h"
#import "OWNetworking.h"

@interface OWQuestionnaireVC ()

@end

@implementation OWQuestionnaireVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"调查问卷";
    
    [self dataRequest];
}

- (void)dataRequest
{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/exam/getResearch") parameters:nil success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            wh_Log(@"---%@",responseObject);
            
            [SVProgressHUD dismiss];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
        wh_Log(@"---%@",error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/


@end
