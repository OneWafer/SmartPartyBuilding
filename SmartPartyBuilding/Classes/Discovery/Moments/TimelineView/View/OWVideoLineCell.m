//
//  OWVideoLineCell.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/18.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIImageView+WebCache.h>
#import <NSString+MLExpression.h>
#import "OWVideoLineCell.h"
#import "MLLabel+Size.h"
#import "OWFaceManager.h"
#import "OWVideoLineItem.h"
#import "OWVideoPlayVC.h"
#import "OWVideoDecoder.h"
#import "OWTool.h"

#define TextFont [UIFont systemFontOfSize:14]

#define TextLineHeight 1.2f

#define TextVideoSpace 10

#define VideoWidth (BodyMaxWidth)*0.9
#define VideoHeight (VideoWidth)*0.7

#define VideoCell @"timeline_cell_video"

@interface OWVideoLineCell ()<OWVideoDecoderDelegate>

@property (strong, nonatomic) MLLinkLabel *textContentLabel;

@property (strong, nonatomic) UIImageView *videoView;

@property (strong, nonatomic) UIButton *clickButton;

@property (strong, nonatomic) OWVideoLineItem *videoItem;

@end

@implementation OWVideoLineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self initCell];
    }
    return self;
}


-(void) initCell
{
    
    if (_textContentLabel == nil) {
        
        _textContentLabel =[[MLLinkLabel alloc] initWithFrame:CGRectZero];
        _textContentLabel.font = TextFont;
        _textContentLabel.numberOfLines = 0;
        _textContentLabel.adjustsFontSizeToFitWidth = NO;
        _textContentLabel.textInsets = UIEdgeInsetsZero;
        
        _textContentLabel.dataDetectorTypes = MLDataDetectorTypeAll;
        _textContentLabel.allowLineBreakInsideLinks = NO;
        _textContentLabel.linkTextAttributes = nil;
        _textContentLabel.activeLinkTextAttributes = nil;
        _textContentLabel.lineHeightMultiple = TextLineHeight;
        _textContentLabel.linkTextAttributes = @{NSForegroundColorAttributeName: HighLightTextColor};
        
        
        [_textContentLabel setDidClickLinkBlock:^(MLLink *link, NSString *linkText, MLLinkLabel *label) {
            NSString *tips = [NSString stringWithFormat:@"Click\nlinkType:%ld\nlinkText:%@\nlinkValue:%@",(unsigned long)link.linkType,linkText,link.linkValue];
            wh_Log(@"%@", tips);
        }];
        
        
        [self.bodyView addSubview:_textContentLabel];
    }
    
    if (_videoView == nil) {
        
        CGFloat x, y , width, height;
        
        x = 0;
        y = 0;
        width = VideoWidth;
        height = VideoHeight;
        
        _videoView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        [self.bodyView addSubview:_videoView];
        
        _clickButton = [[UIButton alloc] initWithFrame:_videoView.frame];
        [self.bodyView addSubview:_clickButton];
        [_clickButton addTarget:self action:@selector(onClickVideo:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}


-(void) onClickVideo:(id) sender
{
    if (_videoItem.localVideoPath == nil || [_videoItem.localVideoPath isEqualToString:@""]) {
        return;
    }
    UINavigationController *controller = [self getController];
    OWVideoPlayVC *playController = [[OWVideoPlayVC alloc] initWithFile:_videoItem.localVideoPath];
    [controller presentViewController:playController animated:YES completion:nil];
}


-(void)updateWithItem:(OWVideoLineItem *)item
{
    [super updateWithItem:item];
    
    _videoItem = item;
    
    CGSize textSize = [MLLinkLabel getViewSize:item.attrText maxWidth:BodyMaxWidth font:TextFont lineHeight:TextLineHeight lines:0];
    
    _textContentLabel.attributedText = item.attrText;
    [_textContentLabel sizeToFit];
    
    _textContentLabel.frame = CGRectMake(0, 0, BodyMaxWidth, textSize.height);
    
    
    CGFloat x, y, width, height;
    x = _videoView.frame.origin.x;
    y = CGRectGetMaxY(_textContentLabel.frame)+TextVideoSpace;
    width = _videoView.frame.size.width;
    height = _videoView.frame.size.height;
    _videoView.frame = CGRectMake(x, y, width, height);
    
    [self updateBodyView:(textSize.height+VideoHeight+TextVideoSpace)];
    
    if (item.thumbImage != nil) {
        _videoView.image = item.thumbImage;
    }else{
        [_videoView sd_setImageWithURL:[NSURL URLWithString:item.thumbUrl]];
    }
    
    
    if (_videoItem.localVideoPath != nil) {
        [self decodeVideo];
    }
    
    NSFileManager *manager = [NSFileManager defaultManager];
    if (_videoItem.videoUrl != nil && ![_videoItem.videoUrl isEqualToString:@""]) {
        
        NSString *key = [OWTool md5:_videoItem.videoUrl];
        NSString *dirPath = [NSString stringWithFormat:@"%@/%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0], @"/videoCache/"];
        BOOL isDir = YES;
        if (![manager fileExistsAtPath:dirPath isDirectory:&isDir]) {
            [manager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        NSString *filePath = [NSString stringWithFormat:@"%@%@.mov",dirPath, key];
        
        if ([manager fileExistsAtPath:filePath]) {
            _videoItem.localVideoPath = filePath;
            [self decodeVideo];
        }else{
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                NSData  *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_videoItem.videoUrl]];
                [data writeToFile:filePath atomically:YES];
                [self performSelectorOnMainThread:@selector(downloadFinish:) withObject:filePath waitUntilDone:NO];
            });
            
        }
        
    }
    
    
}





-(void) downloadFinish:(NSString *) filePath
{
    _videoItem.localVideoPath = filePath;
    [self decodeVideo];
}

-(void) decodeVideo
{
    if (_videoItem.decorder == nil) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            OWVideoDecoder *decoder = [[OWVideoDecoder alloc] initWithFile:_videoItem.localVideoPath];
            decoder.delegate = self;
            _videoItem.decorder = decoder;
            [decoder decode];
        });
    }else{
        [self onDecodeFinished];
    }
}

-(void)onDecodeFinished
{
    //解码完成 刷新界面
    wh_Log(@"解码完成");
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_videoItem.decorder.animation != nil) {
            [_videoView.layer removeAnimationForKey:@"contents"];
            [_videoView.layer addAnimation:_videoItem.decorder.animation forKey:nil];
            
        }
    });
}

-(CGFloat)getCellHeight:(OWVideoLineItem *)item
{
    if (item.attrText == nil) {
        item.attrText  = [item.text expressionAttributedStringWithExpression:[[OWFaceManager sharedInstance] sharedMLExpression]];
    }
    
    CGSize textSize = [MLLinkLabel getViewSize:item.attrText maxWidth:BodyMaxWidth font:TextFont lineHeight:TextLineHeight lines:0];
    
    CGFloat height = [super getCellHeight:item];
    
    return height+textSize.height + VideoHeight+TextVideoSpace;
    
}

@end
