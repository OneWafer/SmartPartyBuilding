//
//  OWScanVC.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/25.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LBXScanNative;
@class LBXScanView;
@class LBXScanViewStyle;
@interface OWScanVC : UIViewController

/** 是否需要扫码图像 */
@property (nonatomic, assign) BOOL isNeedScanImage;
/**  扫码功能封装对象 */
@property (nonatomic,strong) LBXScanNative* scanObj;
/**  扫码区域视图,二维码一般都是框 */
@property (nonatomic,strong) LBXScanView* qRScanView;
/**  界面效果参数 */
@property (nonatomic, strong) LBXScanViewStyle *style;
/**  扫码存储的当前图片 */
@property(nonatomic,strong)UIImage* scanImage;
/**  启动区域识别功能 */
@property(nonatomic,assign)BOOL isOpenInterestRect;
/**  闪关灯开启状态 */
@property(nonatomic,assign)BOOL isOpenFlash;


/** 打开相册 */
- (void)openLocalPhoto;
/** 开关闪光灯 */
- (void)openOrCloseFlash;
/** str 提示语 */
- (void)showError:(NSString*)str;


- (void)reStartDevice;
@end
