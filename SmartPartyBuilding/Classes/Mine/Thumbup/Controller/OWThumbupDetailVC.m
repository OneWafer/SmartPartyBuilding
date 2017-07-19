//
//  OWThumbupDetailVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/7/15.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <ReactiveCocoa.h>
#import <IQKeyboardManager.h>
#import "OWThumbupDetailVC.h"
#import "OWMineThumbup.h"
#import "OWThumCommentVC.h"
#import "OWInputFuncView.h"
#import "UIView+KeyBoardShowAndHidden.h"
#import "OWNetworking.h"
#import "OWMsgComment.h"
#import "OWTool.h"

@interface OWThumbupDetailVC ()<UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *noticeView;
@property (nonatomic, weak) OWInputFuncView *funcView;

@end

@implementation OWThumbupDetailVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = self.thumbup.title ?: @"";
    [self.noticeView loadHTMLString:[OWTool filtrationHtml:@""] baseURL:nil];
    
    [self setupFuncView];
    [self dataRequest];
}


- (void)setupFuncView
{
    [self.funcView showAccessoryViewAnimation];
    [self.funcView hiddenAccessoryViewAnimation];
    wh_weakSelf(self);
    self.funcView.block = ^(NSInteger tag){
        if (tag == 10) {
            [weakself submitComment];
        }else if (tag == 11) {
            [weakself submitThumbup];
        }else if (tag == 12){
            [weakself submitCollection];
        }else{
            OWThumCommentVC *commentVC = [[OWThumCommentVC alloc] init];
            commentVC.thumbup = self.thumbup;
            [weakself.navigationController pushViewController:commentVC animated:YES];
        }
    };
}

- (void)dataRequest
{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    
    RACSignal *detailRequest = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSDictionary *par = @{
                              @"id":@(self.thumbup.praisedId),
                              @"type":@(self.thumbup.type)
                              };
        wh_Log(@"-+-%@",par);
        [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/reply/followDetail") parameters:par success:^(id  _Nullable responseObject) {
            wh_Log(@"+-+%@",responseObject);
            if ([responseObject[@"code"] intValue] == 200) {
                [subscriber sendNext:responseObject[@"data"]];
            }else{
                [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
        }];
        return nil;
    }];
    
    RACSignal *comInfoRequest = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        NSDictionary *par = @{
                              @"id":@(self.thumbup.praisedId),
                              @"type":@(self.thumbup.type)
                              };
        [OWNetworking HPOST:wh_appendingStr(wh_host, @"mobile/reply/replyLikeAndMark") parameters:par success:^(id  _Nullable responseObject) {
            if ([responseObject[@"code"] intValue] == 200) {
                
                [subscriber sendNext:responseObject[@"data"]];
            }else{
                [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
        }];
        
        return nil;
    }];
    
    [self rac_liftSelector:@selector(updateUIWithR1:r2:) withSignalsFromArray:@[detailRequest, comInfoRequest]];
}

// 更新UI
- (void)updateUIWithR1:(id)detail r2:(id)comInfo
{
    [SVProgressHUD dismiss];
    
    [self.noticeView loadHTMLString:[OWTool filtrationHtml:detail[@"detail"] ?: @""] baseURL:nil];
    self.funcView.infoDic = comInfo;
}

- (void)submitComment
{
    [SVProgressHUD showWithStatus:@"正在提交..."];
    NSDictionary *par = @{
                          @"content":self.funcView.commentStr,
                          @"articleId":@(self.thumbup.praisedId),
                          @"articleType":@(self.thumbup.type)
                          };
    [OWNetworking HPOST:wh_appendingStr(wh_host, @"mobile/reply/reply") parameters:par success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            wh_Log(@"---%@",responseObject);
            self.funcView.inputView.text = @"";
            [self dataRequest];
            [SVProgressHUD showSuccessWithStatus:@"评论成功!"];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
    }];
    
}

- (void)submitThumbup
{
    if (self.funcView.thumbupBtn.selected) { // 取消点赞
        NSDictionary *par = @{
                              @"praisedId":@(self.thumbup.praisedId),
                              @"type":@(self.thumbup.type),
                              @"title":self.thumbup.title,
                              @"cover":self.thumbup.cover
                              };
        wh_Log(@"--%@",par);
        [OWNetworking HPOST:wh_appendingStr(wh_host, @"mobile/like/unlike") parameters:par success:^(id  _Nullable responseObject) {
            if ([responseObject[@"code"] intValue] == 200) {
                wh_Log(@"---%@",responseObject);
                self.funcView.thumbupBtn.selected = NO;
            }else{
                [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
            //            wh_Log(@"---%@",error);
        }];
    }else{ // 点赞
        NSDictionary *par = @{
                              @"praisedId":@(self.thumbup.praisedId),
                              @"type":@(self.thumbup.type),
                              @"title":self.thumbup.title,
                              @"cover":self.thumbup.cover
                              };
        wh_Log(@"--%@",par);
        [OWNetworking HPOST:wh_appendingStr(wh_host, @"mobile/like/like") parameters:par success:^(id  _Nullable responseObject) {
            if ([responseObject[@"code"] intValue] == 200) {
                wh_Log(@"---%@",responseObject);
                self.funcView.thumbupBtn.selected = YES;
            }else{
                [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
            //            wh_Log(@"---%@",error);
        }];
    }
}

- (void)submitCollection
{
    if (self.funcView.collectionBtn.selected) { // 取消收藏
        NSDictionary *par = @{
                              @"markedId":@(self.thumbup.praisedId),
                              @"type":@(self.thumbup.type)
                              };
        [OWNetworking HPOST:wh_appendingStr(wh_host, @"mobile/mark/unmark") parameters:par success:^(id  _Nullable responseObject) {
            if ([responseObject[@"code"] intValue] == 200) {
                wh_Log(@"---%@",responseObject);
                self.funcView.collectionBtn.selected = NO;
            }else{
                [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
        }];
    }else{// 收藏
        NSDictionary *par = @{
                              @"markedId":@(self.thumbup.praisedId),
                              @"type":@(self.thumbup.type),
                              @"title":self.thumbup.title,
                              @"cover":self.thumbup.cover
                              };
        [OWNetworking HPOST:wh_appendingStr(wh_host, @"mobile/mark/mark") parameters:par success:^(id  _Nullable responseObject) {
            if ([responseObject[@"code"] intValue] == 200) {
                wh_Log(@"---%@",responseObject);
                self.funcView.collectionBtn.selected = YES;
            }else{
                [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
            }
        } failure:^(NSError * _Nonnull error) {
            [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
        }];
    }
}



#pragma mark - ---------- Lazy ----------

- (UIWebView *)noticeView
{
    if (!_noticeView) {
        UIWebView *view = [[UIWebView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.delegate = self;
        [self.view addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        _noticeView = view;
    }
    return _noticeView;
}

- (OWInputFuncView *)funcView
{
    if (!_funcView) {
        OWInputFuncView *view = [[OWInputFuncView alloc] init];
        [self.view addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.height.equalTo(50);
        }];
        _funcView = view;
    }
    return _funcView;
}



@end
