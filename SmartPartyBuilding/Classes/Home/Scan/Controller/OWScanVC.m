//
//  OWScanVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/25.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <LBXScanView.h>
#import <LBXScanNative.h>
#import "OWScanVC.h"
#import "OWScanPermissions.h"

@interface OWScanVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation OWScanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.view.backgroundColor = [UIColor blackColor];
    self.navigationItem.title = @"二维码";
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self drawScanView];
    
    //不延时，可能会导致界面黑屏并卡住一会
    [self performSelector:@selector(startScan) withObject:nil afterDelay:0.2];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    
    [self stopScan];
    
    [_qRScanView stopScanAnimation];
}

//绘制扫描区域
- (void)drawScanView
{
    if (!_qRScanView)
    {
        CGRect rect = self.view.frame;
        rect.origin = CGPointMake(0, 0);
        
        self.qRScanView = [[LBXScanView alloc]initWithFrame:rect style:_style];
        
        [self.view addSubview:_qRScanView];
    }
    [_qRScanView startDeviceReadyingWithText:@"相机启动中"];
}

- (void)reStartDevice
{
    [_scanObj startScan];
}
//启动设备
- (void)startScan
{
    if ( ![OWScanPermissions cameraPemission] )
    {
        [_qRScanView stopDeviceReadying];
        
        [self showError:@"   请到设置隐私中开启本程序相机权限   "];
        return;
    }
    
    UIView *videoView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))];
    videoView.backgroundColor = [UIColor clearColor];
    [self.view insertSubview:videoView atIndex:0];
    
    wh_weakSelf(self);
    
    if (!_scanObj )
    {
        CGRect cropRect = CGRectZero;
        
        if (_isOpenInterestRect) {
            
            //设置只识别框内区域
            cropRect = [LBXScanView getScanRectWithPreView:self.view style:_style];
        }
        
        NSString *strCode = AVMetadataObjectTypeQRCode;
//        if ([Global sharedManager].scanCodeType != SCT_BarCodeITF ) {
//            
//            strCode = [[Global sharedManager]nativeCodeType];
//        }
        
        //AVMetadataObjectTypeITF14Code 扫码效果不行,另外只能输入一个码制，虽然接口是可以输入多个码制
        self.scanObj = [[LBXScanNative alloc]initWithPreView:videoView ObjectType:@[strCode] cropRect:cropRect success:^(NSArray<LBXScanResult *> *array) {
            
            [weakself scanResultWithArray:array];
        }];
        [_scanObj setNeedCaptureImage:_isNeedScanImage];
    }
    [_scanObj startScan];
    
    [_qRScanView stopDeviceReadying];
    [_qRScanView startScanAnimation];
    
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)stopScan
{
    [_scanObj stopScan];
}

- (void)scanResultWithArray:(NSArray<LBXScanResult*>*)array
{
    if (!array ||  array.count < 1)
    {
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    //经测试，可以同时识别2个二维码，不能同时识别二维码和条形码
//    for (LBXScanResult *result in array) {
//    
//        wh_Log(@"scanResult:%@",result.strScanned);
//    }
    
    LBXScanResult *scanResult = array[0];
    
    NSString*strResult = scanResult.strScanned;
    
    self.scanImage = scanResult.imgScanned;
    
    if (!strResult) {
        
        [self popAlertMsgWithScanResult:nil];
        
        return;
    }
    
    wh_Log(@"%@---%@",strResult,self.scanImage);
    [self.navigationController popViewControllerAnimated:YES];
    
//    //震动提醒
//     [LBXScanWrapper systemVibrate];
//    //声音提醒
//    [LBXScanWrapper systemSound];
    
//    [self showNextVCWithScanResult:scanResult];
    
}

- (void)popAlertMsgWithScanResult:(NSString*)strResult
{
    if (!strResult) {
        
        strResult = @"识别失败";
    }
    
    __weak __typeof(self) weakSelf = self;
//    [LBXAlertAction showAlertWithTitle:@"扫码内容" msg:strResult buttonsStatement:@[@"知道了"] chooseBlock:^(NSInteger buttonIdx) {
//        
//        [weakSelf reStartDevice];
//    }];
}

- (void)showNextVCWithScanResult:(LBXScanResult*)strResult
{
//    ScanResultViewController *vc = [ScanResultViewController new];
//    vc.imgScan = strResult.imgScanned;
//    
//    vc.strScan = strResult.strScanned;
//    
//    vc.strCodeType = strResult.strBarCodeType;
    
//    [self.navigationController pushViewController:vc animated:YES];
}

//开关闪光灯
- (void)openOrCloseFlash
{
    [_scanObj changeTorch];
}

#pragma mark --打开相册并识别图片

/*!
 *  打开本地照片，选择图片识别
 */
- (void)openLocalPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    picker.delegate = self;
    
    //部分机型有问题
    //    picker.allowsEditing = YES;
    
    
    [self presentViewController:picker animated:YES completion:nil];
}

//当选择一张图片后进入这里

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    __block UIImage* image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (!image){
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    __weak __typeof(self) weakSelf = self;
    if ([[[UIDevice currentDevice]systemVersion]floatValue] >= 8.0)
    {
        [LBXScanNative recognizeImage:image success:^(NSArray<LBXScanResult *> *array) {
            [weakSelf scanResultWithArray:array];
        }];
    }
    else
    {
        [self showError:@"native低于ios8.0系统不支持识别图片条码"];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    wh_Log(@"cancel");
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//子类继承必须实现的提示
- (void)showError:(NSString*)str
{
//    [LBXAlertAction showAlertWithTitle:@"提示" msg:str buttonsStatement:@[@"知道了"] chooseBlock:nil];
}

@end
