//
//  OWGridImageView.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <MJPhoto.h>
#import <MJPhotoBrowser.h>
#import <UIImageView+WebCache.h>
#import "OWGridImageView.h"
#import "OWImageUnitView.h"

#define Padding 2

#define OneImageMaxWidth [UIScreen mainScreen].bounds.size.width*0.5

@interface OWGridImageView ()

@property (nonatomic, strong) NSArray *images;

@property (nonatomic, strong) NSArray *srcImages;

@property (nonatomic, strong) NSMutableArray *imageViews;

@property (nonatomic, strong) UIImageView *oneImageView;
@property (nonatomic, strong) UIButton *oneImageButton;

@end

@implementation OWGridImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageViews = [NSMutableArray array];
        
        [self initView];
    }
    return self;
}

- (void)initView
{
    CGFloat x, y, width, height;
    
    width = (self.frame.size.width - 2*Padding)/3;
    height = width;
    
    for (int row=0; row<3; row++) {
        for (int column=0; column<3; column++) {
            
            x = (width+Padding)*column;
            y = (height+Padding)*row;
            OWImageUnitView *imageUnitView = [[OWImageUnitView alloc] initWithFrame:CGRectMake(x, y, width, height)];
            [self addSubview:imageUnitView];
            imageUnitView.hidden = YES;
            [imageUnitView.imageButton addTarget:self action:@selector(onClickImage:) forControlEvents:UIControlEventTouchUpInside];
            
            [_imageViews addObject:imageUnitView];
        }
    }
    
    _oneImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _oneImageView.hidden = YES;
    _oneImageView.backgroundColor = [UIColor lightGrayColor];
    
    
    _oneImageButton = [[UIButton alloc] initWithFrame:CGRectZero];
    _oneImageButton.hidden = YES;
    //_oneImageButton.backgroundColor = [UIColor lightGrayColor];
    [_oneImageButton addTarget:self action: @selector(onClickImage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_oneImageView];
    [self addSubview:_oneImageButton];
    
    
}

- (void)updateWithImages:(NSArray *)images srcImages:(NSArray *)srcImages oneImageWidth:(CGFloat)oneImageWidth oneImageHeight:(CGFloat)oneImageHeight
{
    
    self.images = images;
    self.srcImages = srcImages;
    
    if (images.count > 0) {
        id img = [images firstObject];
        if ([img isKindOfClass:[UIImage class]]) {
            UIImage *image = img;
            oneImageWidth = image.size.width;
            oneImageHeight = image.size.height;
        }
    }
    
    if (images.count == 1) {
        _oneImageView.hidden = NO;
        _oneImageButton.hidden = NO;
        if (oneImageWidth > OneImageMaxWidth) {
            _oneImageView.frame = CGRectMake(0, 0, OneImageMaxWidth, oneImageHeight*(OneImageMaxWidth/oneImageWidth));
            _oneImageButton.frame = CGRectMake(0, 0, OneImageMaxWidth, oneImageHeight*(OneImageMaxWidth/oneImageWidth));;
        }else{
            _oneImageView.frame = CGRectMake(0, 0, oneImageWidth, oneImageHeight);
            _oneImageButton.frame = CGRectMake(0, 0, oneImageWidth, oneImageHeight);
        }
        
        id img = [images firstObject];
        if ([img isKindOfClass:[UIImage class]]) {
            _oneImageView.image = img;
        }else{
            [_oneImageView sd_setImageWithURL:[NSURL URLWithString:[images firstObject]]];
        }
        _oneImageButton.tag = 0;
        
    }else{
        _oneImageView.hidden = YES;
    }
    
    for (int i=0; i< _imageViews.count; i++) {
        OWImageUnitView *imageUnitView = [_imageViews objectAtIndex:i];
        [imageUnitView.imageButton addTarget:self action:@selector(touchUpInside:) forControlEvents:UIControlEventTouchUpInside];
        
        if (images.count == 1) {
            imageUnitView.hidden = YES;
        }else{
            
            if (images.count == 4) {
                if (i == 0 || i == 1 ) {
                    id img = [images objectAtIndex:i];
                    if ([img isKindOfClass:[UIImage class]]) {
                        imageUnitView.imageView.image = img;
                    }else{
                        [imageUnitView.imageView sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:i]]];
                    }
                    imageUnitView.hidden = NO;
                    imageUnitView.imageButton.tag = i;
                }else if (i == 3 || i == 4 ) {
                    
                    id img = [images objectAtIndex:i-1];
                    if ([img isKindOfClass:[UIImage class]]) {
                        imageUnitView.imageView.image = img;
                    }else{
                        [imageUnitView.imageView sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:i-1]]];
                    }
                    
                    imageUnitView.hidden = NO;
                    imageUnitView.imageButton.tag = i-1;
                }else{
                    imageUnitView.hidden = YES;
                }
            }else{
                if (i < images.count) {
                    
                    id img = [images objectAtIndex:i];
                    if ([img isKindOfClass:[UIImage class]]) {
                        imageUnitView.imageView.image = img;
                    }else{
                        [imageUnitView.imageView sd_setImageWithURL:[NSURL URLWithString:[images objectAtIndex:i]]];
                    }
                    
                    imageUnitView.imageButton.tag = i;
                    imageUnitView.hidden = NO;
                }else{
                    imageUnitView.hidden = YES;
                }
            }
        }
        
    }
}


-(void) onClickImage:(UIView *) sender
{
    
    wh_Log(@"tag: %ld", (long)sender.tag);
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    
    NSMutableArray *photos = [NSMutableArray array];
    
    if (self.srcImages.count > 1) {
        
        for (int i=0; i<self.images.count; i++) {
            MJPhoto *photo = [[MJPhoto alloc] init];
            
            id img = [self.srcImages objectAtIndex:i];
            if ([img isKindOfClass:[UIImage class]]) {
                photo.image = img;
            }else{
                photo.url = [NSURL URLWithString:[self.srcImages objectAtIndex:i]];
            }
            photo.srcImageView = ((OWImageUnitView *)[_imageViews objectAtIndex:i]).imageView;
            [photos addObject:photo];
        }
        
    }else{
        MJPhoto *photo = [[MJPhoto alloc] init];
        id img = [self.srcImages firstObject];
        if ([img isKindOfClass:[UIImage class]]) {
            photo.image = img;
        }else{
            photo.url = [NSURL URLWithString:[self.srcImages firstObject]];
        }
        
        photo.srcImageView = _oneImageView;
        [photos addObject:photo];
        
    }
    
    
    browser.photos = photos;
    browser.currentPhotoIndex = sender.tag;
    
    [browser show];
    
    
}


+(CGFloat)getHeight:(NSArray *)images maxWidth:(CGFloat)maxWidth oneImageWidth:(CGFloat)oneImageWidth oneImageHeight:(CGFloat)oneImageHeight
{
    CGFloat height= (maxWidth - 2*Padding)/3;
    
//    if (images == nil || images.count == 0) {
//        return 0.0;
//    }
//    
//    if (images.count == 1) {
//        id img = [images firstObject];
//        if ([img isKindOfClass:[UIImage class]]) {
//            UIImage *image = img;
//            oneImageWidth = image.size.width;
//            oneImageHeight = image.size.height;
//        }
//        
//        if (oneImageWidth > OneImageMaxWidth) {
//            return oneImageHeight*(OneImageMaxWidth/oneImageWidth);
//        }
//        return oneImageHeight;
//    }
//    
//    if (images.count >1 && images.count <=3 ) {
//        return height;
//    }
//    
//    if (images.count >3 && images.count <=6 ) {
//        return height*2+Padding;
//    }
//    
//    return height*3+Padding*2;
    
    if (images == nil || images.count == 0) {
        return 0.0;
    }else if (images.count == 1) {
        id img = [images firstObject];
        if ([img isKindOfClass:[UIImage class]]) {
            UIImage *image = img;
            oneImageWidth = image.size.width;
            oneImageHeight = image.size.height;
        }else if (oneImageWidth > OneImageMaxWidth) {
            return oneImageHeight*(OneImageMaxWidth/oneImageWidth);
        }
        return oneImageHeight;
    }else if (images.count >1 && images.count <=3 ) {
        return height;
    }else if (images.count >3 && images.count <=6 ) {
        return height*2+Padding;
    }else {
        return height*3+Padding*2;
    }
}


- (void)touchUpInside:(id)sender
{
    wh_Log(@"%@", sender);
}


-(NSInteger) getIndexFromPoint: (CGPoint) point
{
    
    UIView *view = self.superview.superview.superview;
    //wh_Log(@"view: %@", view);
    wh_Log(@"touch: x: %f  y: %f", point.x, point.y);
    
    CGFloat x = view.frame.origin.x + self.frame.origin.x+60;
    CGFloat y = view.frame.origin.y + self.frame.origin.y;
    
    wh_Log(@"abs-grid: x: %f  y:%f", x, y);
    
    NSInteger diffY = point.y - y;
    NSInteger diffX = point.x - x;
    if (diffY <0 || diffX <0) {
        return -1;
    }
    
    if (_images.count == 1) {
        if (diffX > _oneImageButton.frame.size.width || diffY > _oneImageButton.frame.size.height) {
            return -1;
        }
        return 0;
    }
    
    
    wh_Log(@"diffY: %ld  diffX: %ld", diffY, diffX);
    
    CGFloat gridWidth = self.frame.size.width;
    NSInteger size = gridWidth/3+20;
    //wh_Log(@"size: %ld", size);
    
    if (diffY> gridWidth || diffX > gridWidth) {
        return -1;
    }
    
    
    NSInteger index = diffX/size + 3*(diffY/size);
    wh_Log(@"index: %ld", index);
    
    if (_images.count == 4) {
        if (index == 2) {
            return -1;
        }
        if (index >=3) {
            index--;
        }
    }
    
    if (index<0 || index>_images.count-1) {
        return -1;
    }
    
    return index;
}

@end
