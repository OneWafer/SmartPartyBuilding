//
//  OWNoticeDetailVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/6/25.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <Masonry.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import <IQKeyboardManager.h>
#import "OWNoticeDetailVC.h"
#import "OWMessage.h"
#import "OWInputFuncView.h"
#import "UIView+KeyBoardShowAndHidden.h"
#import "OWNetworking.h"
#import "OWMsgComment.h"
#import "OWHomeCommentVC.h"

@interface OWNoticeDetailVC ()<UIWebViewDelegate>

@property (nonatomic, weak) UIWebView *messageView;
@property (nonatomic, weak) OWInputFuncView *funcView;

@end

@implementation OWNoticeDetailVC

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
    
    self.navigationItem.title = @"详情";
    [self.messageView loadHTMLString:self.message.newsContent baseURL:nil];
    
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
            OWHomeCommentVC *commentVC = [[OWHomeCommentVC alloc] init];
            commentVC.message = self.message;
            [weakself.navigationController pushViewController:commentVC animated:YES];
        }
    };
}

- (void)dataRequest
{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    NSDictionary *par = @{
                          @"id":@(self.message.id),
                          @"type":@(2)
                          };
    [OWNetworking HPOST:wh_appendingStr(wh_host, @"mobile/reply/replyLikeAndMark") parameters:par success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            self.funcView.infoDic = responseObject[@"data"];
            [SVProgressHUD dismiss];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
    }];
}

- (void)submitComment
{
    [SVProgressHUD showWithStatus:@"正在提交..."];
    NSDictionary *par = @{
                          @"content":self.funcView.commentStr,
                          @"articleId":@(self.message.id),
                          @"articleType":@(2)
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
                              @"praisedId":@(self.message.id),
                              @"type":@(2)
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
                              @"praisedId":@(self.message.id),
                              @"type":@(2),
                              @"title":self.message.title,
                              @"cover":@""
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
                              @"markedId":@(self.message.id),
                              @"type":@(2)
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
                              @"markedId":@(self.message.id),
                              @"type":@(2),
                              @"title":self.message.title,
                              @"cover":@""
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

- (UIWebView *)messageView
{
    if (!_messageView) {
        UIWebView *view = [[UIWebView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.delegate = self;
        [self.view addSubview:view];
        
        [view makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        _messageView = view;
    }
    return _messageView;
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
