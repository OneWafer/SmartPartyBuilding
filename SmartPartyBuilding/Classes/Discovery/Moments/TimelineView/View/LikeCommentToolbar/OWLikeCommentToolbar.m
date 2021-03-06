//
//  OWLikeCommentToolbar.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWLikeCommentToolbar.h"

@interface OWLikeCommentToolbar ()

@property (nonatomic, strong) UIButton *likeButton;

@property (nonatomic, strong) UIButton *commentButton;

@end

@implementation OWLikeCommentToolbar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self initView];
    }
    return self;
}

-(void) initView
{
    
    self.userInteractionEnabled = YES;
    
    UIImage *image = [UIImage imageNamed:@"AlbumOperateMoreViewBkg"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeStretch];
    self.image = image;
    
    
    
    CGFloat x, y, width, height;
    
    x=0;
    y=0;
    width = self.frame.size.width/2;
    height = self.frame.size.height;
    
    _likeButton = [self getButton:CGRectMake(x, y, width, height) title:@"赞" image:@"AlbumLike"];
    [_likeButton addTarget:self action:@selector(onLike:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_likeButton];
    
    x = width;
    _commentButton = [self getButton:CGRectMake(x, y, width, height) title:@"0" image:@"AlbumComment"];
    [_commentButton addTarget:self action:@selector(onComment:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_commentButton];
    
    //分割线
    height = height -16;
    y = (self.frame.size.height - height)/2;
    width = 1;
    UIView *divider = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
    divider.backgroundColor = [UIColor whiteColor];
    [self addSubview:divider];
    
}

-(UIButton *) getButton:(CGRect) frame title:(NSString *) title image:(NSString *) image
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    //btn.backgroundColor = [UIColor redColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    return btn;
}

- (void)setNum:(NSString *)num
{
    _num = num;
    [_commentButton setTitle:num forState:UIControlStateNormal];
}

-(void) onLike:(id) sender
{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(onLike)]) {
        [_delegate onLike];
    }
    
}


-(void) onComment:(id) sender
{
    if (_delegate != nil && [_delegate respondsToSelector:@selector(onComment)]) {
        [_delegate onComment];
    }
}

@end
