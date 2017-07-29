//
//  OWImagesSendVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/18.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <MJPhoto.h>
#import <Masonry.h>
#import <ReactiveCocoa.h>
#import <LCActionSheet.h>
#import <MJPhotoBrowser.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <TZImagePickerController.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "OWImagesSendVC.h"
#import "OWPlainGridImageView.h"
#import "MLLabel+Size.h"
#import "OWMomentLocationVC.h"
#import "OWNavigationController.h"

#define ImageGridWidth wh_screenWidth*0.7

@interface OWImagesSendVC ()<OWPlainGridImageViewDelegate, TZImagePickerControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>

@property (nonatomic, strong) NSMutableArray *images;

@property (nonatomic, weak) UITextView *contentView;

@property (nonatomic, strong) UIView *mask;

@property (nonatomic, weak) UILabel *placeholder;

@property (nonatomic, weak) OWPlainGridImageView *gridView;

@property (nonatomic, weak) UIView *lineView1;
@property (nonatomic, weak) UIView *lineView2;
@property (nonatomic, weak) UIImageView *locationImgView;
@property (nonatomic, weak) UILabel *locationLabel;
@property (nonatomic, weak) UIButton *locationBtn;
@property (nonatomic, copy) NSString *locationStr;

@property (nonatomic, strong) UIImagePickerController *pickerController;

@property (strong, nonatomic) UIPanGestureRecognizer *panGestureRecognizer;
@property (strong, nonatomic) UITapGestureRecognizer *tapGestureRecognizer;

@end

@implementation OWImagesSendVC

- (instancetype)initWithImages:(NSArray *) images
{
    self = [super init];
    if (self) {
        _images = [NSMutableArray array];
        if (images != nil) {
            [_images addObjectsFromArray:images];
            [_images addObject:[UIImage imageNamed:@"AlbumAddBtn"]];
        }
    }
    return self;
}

- (void)dealloc
{
    
    [_mask removeGestureRecognizer:_panGestureRecognizer];
    [_mask removeGestureRecognizer:_tapGestureRecognizer];
}


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
    [self setupNavi];
}


- (void)setupNavi
{
    wh_weakSelf(self);
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem wh_itemWithType:WHItemTypeLeft norTitle:@"取消" font:15.5f norColor:[UIColor blackColor] highColor:[UIColor blackColor] offset:0 actionHandler:^(UIButton *sender) {
        
        [weakself dismissViewControllerAnimated:YES completion:nil];
    }];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem wh_itemWithType:WHItemTypeRight norTitle:@"发送" font:15.5f norColor:[UIColor blackColor] highColor:[UIColor blackColor] offset:0 actionHandler:^(UIButton *sender) {
        
        if (weakself.delegate && [weakself.delegate respondsToSelector:@selector(onSendTextImage:images:location:)]) {
            
            [weakself.images removeLastObject];
            [weakself.delegate onSendTextImage:weakself.contentView.text images:weakself.images location:self.locationStr ?: @""];
        }
        
        [weakself dismissViewControllerAnimated:YES completion:nil];
        
    }];
}

-(void) initView
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.contentView.rac_textSignal subscribeNext:^(NSString *x) {
        wh_Log(@"---%@",x);
    }];
    self.placeholder.text = @"这一刻的想法...";
    
    
    [self refreshGridImageView];
    
    
    self.lineView1.backgroundColor = wh_lineColor;
    self.lineView2.backgroundColor = wh_lineColor;
    
    self.locationLabel.text = @"所在位置";
    
    wh_weakSelf(self);
    [self.locationBtn wh_addActionHandler:^(UIButton *sender) {
        OWMomentLocationVC *locationVC = [[OWMomentLocationVC alloc] init];
        locationVC.block = ^(AMapPOI * poi){
            weakself.locationStr = poi.name ?: @"";
            weakself.locationLabel.text = poi.name;
        };
        OWNavigationController *nav = [[OWNavigationController alloc] initWithRootViewController:locationVC];
        [self presentViewController:nav animated:YES completion:nil];
    }];
    
    _mask = [[UIView alloc] initWithFrame:self.view.bounds];
    _mask.backgroundColor = [UIColor clearColor];
    _mask.hidden = YES;
    [self.view addSubview:_mask];
    
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanAndTap:)];
    [_mask addGestureRecognizer:_panGestureRecognizer];
    _panGestureRecognizer.maximumNumberOfTouches = 1;
    
    _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onPanAndTap:)];
    [_mask addGestureRecognizer:_tapGestureRecognizer];
    
    
    
}

-(void) refreshGridImageView
{
    CGFloat height = [OWPlainGridImageView getHeight:self.images maxWidth:ImageGridWidth];
    [self.gridView remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.contentView.bottom).offset(10);
        make.width.equalTo(ImageGridWidth);
        make.height.equalTo(height);
    }];
    [self.gridView updateWithImages:_images];
}



-(void) onPanAndTap:(UIGestureRecognizer *) gesture
{
    _mask.hidden = YES;
    [_contentView resignFirstResponder];
}



#pragma mark - UITextViewDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (![text isEqualToString:@""])
    {
        _placeholder.hidden = YES;
    }else if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
    {
        _placeholder.hidden = NO;
        
    }
    
    return YES;
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    _mask.hidden = NO;
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    _mask.hidden = YES;
}

#pragma mark - DFPlainGridImageViewDelegate

-(void)onClick:(NSUInteger)index
{
    
    if (_images.count <= 9 && index == _images.count-1) {
        [self chooseImage];
    }else{
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        
        NSMutableArray *photos = [NSMutableArray array];
        NSUInteger count;
        if (_images.count > 9)  {
            count = 9;
        }else{
            count = _images.count - 1;
        }
        for (int i=0; i<count; i++) {
            MJPhoto *photo = [[MJPhoto alloc] init];
            photo.image = [_images objectAtIndex:i];
            [photos addObject:photo];
        }
        browser.photos = photos;
        browser.currentPhotoIndex = index;
        
        [browser show];
        
    }
}


-(void)onLongPress:(NSUInteger)index
{
    
    if (_images.count <9 && index == _images.count-1) {
        return;
    }
    
    wh_weakSelf(self);
    LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:nil cancelButtonTitle:@"取消" clicked:^(LCActionSheet * _Nonnull actionSheet, NSInteger buttonIndex) {
        if (buttonIndex == 0) return;
        [weakself.images removeObjectAtIndex:index];
        [weakself refreshGridImageView];
        
        
    } otherButtonTitleArray:@[@"删除"]];
    [actionSheet show];
    
}

-(void) chooseImage
{
    
    wh_weakSelf(self);
    LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:nil cancelButtonTitle:@"取消" clicked:^(LCActionSheet * _Nonnull actionSheet, NSInteger buttonIndex) {
        
        switch (buttonIndex) {
            case 1:
                [weakself takePhoto];
                break;
            case 2:
                [weakself pickFromAlbum];
                break;
            default:
                break;
        }
        
    } otherButtonTitleArray:@[@"拍照", @"从相册选取"]];
    [actionSheet show];
}


-(void) takePhoto
{
    _pickerController = [[UIImagePickerController alloc] init];
    _pickerController.delegate = self;
    _pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:_pickerController animated:YES completion:nil];
}

-(void) pickFromAlbum
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:(10-_images.count) delegate:self];
    imagePickerVc.allowPickingVideo = NO;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    wh_Log(@"%@", photos);
    
    for (UIImage *image in photos) {
        [_images insertObject:image atIndex:(_images.count-1)];
    }
    
    [self refreshGridImageView];
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [_pickerController dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    [_images insertObject:image atIndex:(_images.count-1)];
    
    [self refreshGridImageView];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [_pickerController dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - ---------- Lazy ----------

- (UITextView *)contentView
{
    if (!_contentView) {
        UITextView *tv = [[UITextView alloc] init];
        tv.scrollEnabled = YES;
        tv.delegate = self;
        tv.font = [UIFont systemFontOfSize:17];
        [self.view addSubview:tv];
        
        [tv makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(10);
            make.top.equalTo(self.view).offset(74);
            make.right.equalTo(self.view).offset(-10);
            make.height.equalTo(100);
        }];
        _contentView = tv;
    }
    return _contentView;
}


- (UILabel *)placeholder
{
    if (!_placeholder) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor = [UIColor lightGrayColor];
        label.enabled = NO;
        [self.view addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(5);
            make.top.equalTo(self.contentView).offset(8);
        }];
        _placeholder = label;
    }
    return _placeholder;
}


- (OWPlainGridImageView *)gridView
{
    if (!_gridView) {
        OWPlainGridImageView *imgView = [[OWPlainGridImageView alloc] init];
        imgView.delegate = self;
        [self.view addSubview:imgView];
        CGFloat height = [OWPlainGridImageView getHeight:self.images maxWidth:ImageGridWidth];
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(10);
            make.top.equalTo(self.contentView.bottom).offset(10);
            make.width.equalTo(ImageGridWidth);
            make.height.equalTo(height);
        }];
        _gridView = imgView;
    }
    return _gridView;
}

- (UIView *)lineView1
{
    if (!_lineView1) {
        UIView *view = [[UIView alloc] init];
        [self.view addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.gridView);
            make.top.equalTo(self.gridView.bottom).offset(15);
            make.right.equalTo(self.view);
            make.height.equalTo(0.5);
        }];
        _lineView1 = view;
    }
    return _lineView1;
}

- (UIView *)lineView2
{
    if (!_lineView2) {
        UIView *view = [[UIView alloc] init];
        [self.view addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.lineView1).offset(45);
            make.height.equalTo(0.5);
        }];
        _lineView2 = view;
    }
    return _lineView2;
}

- (UIImageView *)locationImgView
{
    if (!_locationImgView) {
        UIImageView *imgView = [[UIImageView alloc] initWithImage:wh_imageNamed(@"discovery_location")];
        [self.view addSubview:imgView];
        
        [imgView makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.lineView1.bottom).offset(22.5);
            make.left.equalTo(self.view).offset(15);
        }];
        _locationImgView = imgView;
    }
    return _locationImgView;
}


- (UILabel *)locationLabel
{
    if (!_locationLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14.5f];
        label.textColor = wh_norFontColor;
        [self.view addSubview:label];
        
        [label makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.locationImgView.right).offset(10);
            make.top.bottom.equalTo(self.locationImgView);
        }];
        _locationLabel = label;
    }
    return _locationLabel;
}

- (UIButton *)locationBtn
{
    if (!_locationBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:btn];
        
        [btn makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.lineView1);
            make.bottom.equalTo(self.lineView2);
        }];
        _locationBtn = btn;
    }
    return _locationBtn;
}

@end
