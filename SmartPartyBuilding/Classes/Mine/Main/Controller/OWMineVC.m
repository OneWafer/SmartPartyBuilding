//
//  OWMineVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/14.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <LCActionSheet.h>
#import <SVProgressHUD.h>
#import "OWMineVC.h"
#import "OWUserInfoVC.h"
#import "OWSettingVC.h"
#import "OWMineHeaderView.h"
#import "OWMineOptionCell.h"
#import "AppDelegate.h"
#import "OWTool.h"
#import "OWPartyFeeVC.h"
#import "OWNetworking.h"

@interface OWMineVC ()<LCActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) OWMineHeaderView *headerView;
@property (nonatomic, strong) UIImagePickerController *imgPickerVC;
@property (nonatomic, strong) NSArray *optionList;
@property (nonatomic, weak) UIButton *logoutBtn;

@end

@implementation OWMineVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //设置背景透明图片
    [self.navigationController.navigationBar setValue:@0 forKeyPath:@"backgroundView.alpha"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController.navigationBar setValue:@1 forKeyPath:@"backgroundView.alpha"];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    [self setupNavi];
    [self setupLogoutBtn];
    
    
}

/** 设置tableview */
- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = NO;
    CGFloat bottomEdge = 667.0f - wh_screenHeight;
    if (bottomEdge <= 0) bottomEdge = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, bottomEdge, 0);
    
    self.headerView = [[OWMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, wh_screenWidth, 150)];
    self.tableView.tableHeaderView = self.headerView;
    wh_weakSelf(self);
    self.headerView.headerBlock = ^(NSInteger tag){
        if (tag == 11) {
            OWUserInfoVC *userInfoVC = [[OWUserInfoVC alloc] init];
            [weakself.navigationController pushViewController:userInfoVC animated:YES];
        }else{
            [weakself takePhoto];
        }
    };
    
    self.optionList = @[
                        @{@"image" : @"mine_collection", @"title" : @"收藏"},
                        @{@"image" : @"mine_comment", @"title" : @"评论"},
                        @{@"image" : @"mine_release", @"title" : @"发布"},
                        @{@"image" : @"mine_pay", @"title" : @"党费缴纳"},
                        @{@"image" : @"mine_signIn", @"title" : @"签到"}
                        ];
}

/** 设置UIBarButtonItem */
- (void)setupNavi
{
    wh_weakSelf(self);
    UIBarButtonItem *setItem = [UIBarButtonItem wh_itemWithType:WHItemTypeRight norImage:@"navi_setting" highImage:@"navi_setting" offset:0.0f actionHandler:^(UIButton *sender) {
        OWSettingVC *settingVC = [[OWSettingVC alloc] init];
        [weakself.navigationController pushViewController:settingVC animated:YES];
    }];
    
    UIBarButtonItem *messageItem = [UIBarButtonItem wh_itemWithType:WHItemTypeRight norImage:@"navi_me_message" highImage:@"navi_me_message" offset:0.0f actionHandler:^(UIButton *sender) {
        wh_Log(@"点击了消息按钮");
    }];
    
    self.navigationItem.rightBarButtonItems = @[messageItem, setItem];
}

/** 设置退出登录按钮 */
- (void)setupLogoutBtn
{
//    wh_weakSelf(self);
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.logoutBtn wh_addActionHandler:^(UIButton *sender) {
        [UIAlertView wh_alertWithTitle:@"提示" message:@"确定退出登录吗?" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] CallBackBlock:^(NSInteger buttonIndex) {
            if (buttonIndex == 0) return;
            [app login];
        }];
    }];
}

- (void)takePhoto
{
    wh_weakSelf(self);
    LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:nil cancelButtonTitle:@"取消" clicked:^(LCActionSheet *actionSheet, NSInteger buttonIndex) {
        
        if (buttonIndex == 0) return;
        weakself.imgPickerVC.allowsEditing = YES;
        weakself.imgPickerVC.sourceType = (buttonIndex == 1) ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        if (buttonIndex == 1) weakself.imgPickerVC.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        [weakself presentViewController:self.imgPickerVC animated:YES completion:nil];
        
    } otherButtonTitleArray:@[@"拍摄",@"从相册选取"]];
    [actionSheet show];
}

- (void)signIn
{
    [SVProgressHUD showWithStatus:@"正在打卡..."];
    [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/staff/userSign") parameters:nil success:^(id  _Nullable responseObject) {
        wh_Log(@"---%@",responseObject);
        if ([responseObject[@"code"] intValue] == 200) {
            
            [SVProgressHUD showSuccessWithStatus:@"签到成功!"];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
        wh_Log(@"---%@",error);
    }];
}


#pragma mark - ----------UIImagePickerControllerDelegate----------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        
        
    }
}


#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section? 2 : 3;
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
    
    OWMineOptionCell *cell = [OWMineOptionCell cellWithTableView:tableView];
    cell.optionDic = self.optionList[indexPath.row + indexPath.section * 3];
    return cell;
    
}


#pragma mark - ---------- TableViewDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    }else{
        if (indexPath.row == 0) {
            OWPartyFeeVC *pfVC = [[OWPartyFeeVC alloc] init];
            [self.navigationController pushViewController:pfVC animated:YES];
        }else{
            [self signIn];
        }
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - ---------- Lazy ----------

- (UIImagePickerController *)imgPickerVC
{
    if (!_imgPickerVC) {
        _imgPickerVC = [[UIImagePickerController alloc] init];
        _imgPickerVC.delegate = self;
        _imgPickerVC.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imgPickerVC.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
    }
    return _imgPickerVC;
}


- (UIButton *)logoutBtn
{
    if (!_logoutBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"退出登录" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15.5f];
        [btn setBackgroundColor:wh_themeColor];
        [self.tableView addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.equalTo(self.tableView).offset(430);
            make.width.equalTo(self.view).multipliedBy(0.8);
            make.height.equalTo(45);
        }];
        btn.layer.cornerRadius = 4;
        _logoutBtn = btn;
    }
    return _logoutBtn;
}


@end
