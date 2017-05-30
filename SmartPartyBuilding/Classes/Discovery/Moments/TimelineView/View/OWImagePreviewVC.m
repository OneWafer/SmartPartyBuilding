//
//  OWImagePreviewVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/18.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIImageView+WebCache.h>
#import "OWImagePreviewVC.h"

@interface OWImagePreviewVC ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) NSArray *actions;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) long long itemId;

@end

@implementation OWImagePreviewVC

- (instancetype)initWithImageUrl:(NSString *) url itemId:(long long)itemId
{
    self = [super init];
    if (self) {
        _url = url;
        _itemId = itemId;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    //_imageView.backgroundColor = [UIColor redColor];
    //_imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:_url]];
    
    [self.view addSubview:_imageView];
    
    
    
    
    UIPreviewAction *likeAction=[UIPreviewAction actionWithTitle:@"赞" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * action, UIViewController * previewViewController) {
        if (_delegate && [_delegate respondsToSelector:@selector(onLike:)]) {
            [_delegate onLike:_itemId];
        }
    }];
    
    UIPreviewAction *commentAction=[UIPreviewAction actionWithTitle:@"评论" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction *action, UIViewController * previewViewController) {
        if (_delegate && [_delegate respondsToSelector:@selector(onComment:)]) {
            [_delegate onComment:_itemId];
        }
    }];
    
    
    self.actions=@[likeAction,commentAction];
    
    
}


- (NSArray<id<UIPreviewActionItem>> *)previewActionItems
{
    return self.actions;
}

@end
