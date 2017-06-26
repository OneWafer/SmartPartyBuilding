//
//  OWUserInfoVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/16.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <LCActionSheet.h>
#import <SVProgressHUD.h>
#import "OWUserInfoVC.h"
#import "OWUserInfoCell.h"
#import "OWUserInfoAvatarCell.h"
#import "OWNetworking.h"
#import "OWTool.h"

@interface OWUserInfoVC ()<LCActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImagePickerController *imgPickerVC;
@property (nonatomic, strong) NSArray *optionList;

@end

@implementation OWUserInfoVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setValue:@1 forKeyPath:@"backgroundView.alpha"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"资料管理";
    [self setupTableView];
}

/** 设置tableview */
- (void)setupTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    NSDictionary *userInfo = [OWTool getUserInfo];
    self.optionList = @[
                        @{@"title" : @"头像", @"content" : userInfo[@"avatar"] ?: @""},
                        @{@"title" : @"名字", @"content" : userInfo[@"staffName"] ?: @""},
                        @{@"title" : @"性别", @"content" : [userInfo[@"staffName"] intValue] ? @"男": @"女"},
                        @{@"title" : @"个性签名", @"content" : userInfo[@""] ?: @""},
                        @{@"title" : @"我的地址", @"content" : userInfo[@"address"] ?: @""},
                        ];
}

#pragma mark - ---------- TableViewDataSource ----------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return section ? 2 : 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.section == 0 && indexPath.row == 0) ? 80.0f : 47.0f;
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
    if (indexPath.section == 0 && indexPath.row == 0) {
        OWUserInfoAvatarCell *cell = [OWUserInfoAvatarCell cellWithTableView:tableView];
        cell.tag = 1001 + indexPath.row;
        cell.optionDic = self.optionList[indexPath.row];
        return cell;
    }else{
        OWUserInfoCell *cell = [OWUserInfoCell cellWithTableView:tableView];
        cell.optionDic = self.optionList[indexPath.row + indexPath.section * 3];
        return cell;
    }
}


#pragma mark - ---------- TableViewDataDelegate ----------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
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
    }
}


#pragma mark - ----------UIImagePickerControllerDelegate----------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
        OWUserInfoAvatarCell *cell = [self.view viewWithTag:1001];
        
        [SVProgressHUD showWithStatus:@"正在上传..."];
        [OWNetworking HPOST:wh_appendingStr(wh_host, @"mobile/staff/uploadAvatar") parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(img, 0.1) name:@"file" fileName:@"head.jpg" mimeType:@"image/jpg"];
        } success:^(id  _Nullable responseObject) {
            if ([responseObject[@"code"] intValue] == 200) {
                cell.avatarImgView.image = img;
                [SVProgressHUD showSuccessWithStatus:@"上传成功!"];
            }else{
                [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
            wh_Log(@"--%@",error);
        }];
    }
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
@end
