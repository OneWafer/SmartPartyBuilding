//
//  OWNewsDetailVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/23.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import "OWNewsDetailVC.h"
#import "OWNews.h"

@interface OWNewsDetailVC ()<UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *newsView;

@end

@implementation OWNewsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"党建要闻";
    [self.newsView loadHTMLString:self.news.newsContent baseURL:nil];
}



#pragma mark - ---------- Lazy ----------

- (UIWebView *)newsView
{
    if (!_newsView) {
        UIWebView *view = [[UIWebView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.delegate = self;
        [self.view addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        _newsView = view;
    }
    return _newsView;
}

@end
