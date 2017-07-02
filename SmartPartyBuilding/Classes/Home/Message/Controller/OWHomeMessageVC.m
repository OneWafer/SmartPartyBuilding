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

@interface OWHomeMessageVC ()

@end

@implementation OWHomeMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"消息";
    [self dataRequest];
}

- (void)dataRequest
{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    NSDictionary *par = @{
                          @"isRead":@(0)
                          };
    [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/message/getSysMessages") parameters:par success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            wh_Log(@"---%@",responseObject);
            [SVProgressHUD dismiss];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
        wh_Log(@"---%@",error);
    }];
}

@end
