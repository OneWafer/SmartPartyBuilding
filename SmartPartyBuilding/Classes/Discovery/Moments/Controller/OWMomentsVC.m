//
//  OWMomentsVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/18.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "OWMomentsVC.h"
#import "OWTextImageLineItem.h"
#import "OWLineLikeItem.h"
#import "OWLineCommentItem.h"
#import "OWVideoLineItem.h"
#import "OWUserMomentsVC.h"
#import "OWNetworking.h"
#import "OWTool.h"
#import "OWMoment.h"
#import "OWMomentCommentVC.h"

@interface OWMomentsVC ()

@property (nonatomic, strong) NSArray *momentList;

@end

@implementation OWMomentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"光影";
    [self setHeader];
    [self dataRequest];
}

- (void)dataRequest
{
    [SVProgressHUD showWithStatus:@"正在加载..."];
    NSDictionary *par = @{
                          @"isShadow":@(1)
                          };
    [OWNetworking HGET:wh_appendingStr(wh_host, @"mobile/discussion/getList") parameters:par success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            wh_Log(@"---%@",responseObject);
            self.momentList = [OWMoment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self initData];
            [SVProgressHUD dismiss];
            [self endRefresh];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
    }];
}

-(void) setHeader
{
    NSString *coverUrl = @"http://bpic.588ku.com/back_pic/04/27/56/99583becb4a8df7.jpg!/fh/300/quality/90/unsharp/true/compress/true";
    [self setCover:coverUrl];
    
    [self setUserAvatar:[OWTool getUserInfo][@"avatar"]];
    
    [self setUserNick:[OWTool getUserInfo][@"staffName"]];
    
    [self setUserSign:[OWTool getUserInfo][@"signature"]];
    
}


-(void) initData
{
    [self.momentList wh_each:^(OWMoment *obj) {
        
        OWTextImageLineItem *item = [[OWTextImageLineItem alloc] init];
        item.itemId = obj.id;
        item.userId = obj.userId;
        item.userAvatar = obj.avatar;
        item.userNick = obj.staffName;
        item.text = obj.title;
        item.num = [NSString stringWithFormat:@"%d",obj.replyNum];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSDate * date = [dateformatter dateFromString:obj.createTime];
        item.ts = [date timeIntervalSince1970];
        if (obj.url) {
            NSArray *imgList = [obj.url componentsSeparatedByString:@","];
            item.srcImages = imgList;
            item.thumbImages = imgList;
            item.thumbPreviewImages = imgList;
        }
        
        item.width = wh_screenWidth * 0.36;
        item.height = wh_screenWidth * 0.36;
        if (obj.addressInfo) item.location = obj.addressInfo;
        [self addItem:item];
    }];
}


-(void)onCommentCreate:(long long)commentId text:(NSString *)text itemId:(long long) itemId
{
    OWLineCommentItem *commentItem = [[OWLineCommentItem alloc] init];
    commentItem.commentId = [[NSDate date] timeIntervalSince1970];
    commentItem.userId = 10098;
    commentItem.userNick = @"金三胖";
    commentItem.text = text;
    [self addCommentItem:commentItem itemId:itemId replyCommentId:commentId];
}


-(void)onLike:(long long)itemId
{
    //点赞
//    NSDictionary *userInfo = [OWTool getUserInfo];
//    OWLineLikeItem *likeItem = [[OWLineLikeItem alloc] init];
//    likeItem.userId = [userInfo[@"staffId"] integerValue];
//    likeItem.userNick = userInfo[@"staffName"];
//    [self addLikeItem:likeItem itemId:itemId];
    wh_Log(@"点赞了!");
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWMoment *moment = self.momentList[indexPath.row];
    OWMomentCommentVC *commentVC = [[OWMomentCommentVC alloc] init];
    commentVC.momentId = moment.id;
    [self.navigationController pushViewController:commentVC animated:YES];
}

-(void)onClickUser:(NSUInteger)userId
{
    //点击左边头像 或者 点击评论和赞的用户昵称
//    wh_Log(@"onClickUser: %ld", userId);

    OWUserMomentsVC *controller = [[OWUserMomentsVC alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}


-(void)onClickHeaderUserAvatar
{
    [self onClickUser:1111];
}






-(void) refresh
{
    self.momentList = [NSArray array];
    self.items = [NSMutableArray array];
    self.itemDic = [NSMutableDictionary dictionary];
    self.commentDic = [NSMutableDictionary dictionary];
    [self dataRequest];
}



-(void) loadMore
{
    //加载更多
    //模拟网络请求
    dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        
//        OWTextImageLineItem *textImageItem = [[OWTextImageLineItem alloc] init];
//        textImageItem.itemId = 3;
//        textImageItem.userId = 10018;
//        textImageItem.userAvatar = @"http://file-cdn.datafans.net/avatar/1.jpeg";
//        textImageItem.userNick = @"富二代";
//        textImageItem.title = @"发表了";
//        textImageItem.text = @"你才是富二代";
//        
//        
//        NSMutableArray *srcImages3 = [NSMutableArray array];
//        [srcImages3 addObject:@"http://file-cdn.datafans.net/temp/11.jpg"];
//        textImageItem.srcImages = srcImages3;
//        
//        
//        NSMutableArray *thumbImages3 = [NSMutableArray array];
//        [thumbImages3 addObject:@"http://file-cdn.datafans.net/temp/11.jpg_640x420.jpeg"];
//        textImageItem.thumbImages = thumbImages3;
//        
//        
//        NSMutableArray *thumbPreviewImages3 = [NSMutableArray array];
//        [thumbPreviewImages3 addObject:@"http://file-cdn.datafans.net/temp/11.jpg_600x600.jpeg"];
//        textImageItem.thumbPreviewImages = thumbPreviewImages3;
//        
//        
//        textImageItem.width = 640;
//        textImageItem.height = 360;
//        
//        
//        
//        
//        textImageItem.location = @"广州信息港";
//        [self addItem:textImageItem];
        
        [self endLoadMore];
    });
}



//选择照片后得到数据
-(void)onSendTextImage:(NSString *)text images:(NSArray *)images location:(NSString *)location
{
    NSDictionary *userInfo = [OWTool getUserInfo];
    OWTextImageLineItem *textImageItem = [[OWTextImageLineItem alloc] init];
    textImageItem.itemId = 10000000; //随便设置一个 待服务器生成
    textImageItem.userId = [userInfo[@"staffId"] integerValue];
    textImageItem.userAvatar = userInfo[@"avatar"];
    textImageItem.userNick = userInfo[@"staffName"];
    textImageItem.text = text;
    textImageItem.ts = [[NSDate date] timeIntervalSince1970];
    
    NSMutableArray *srcImages = [NSMutableArray array];
    textImageItem.srcImages = srcImages; //大图 可以是本地路径 也可以是网络地址 会自动判断
    
    NSMutableArray *thumbImages = [NSMutableArray array];
    textImageItem.thumbImages = thumbImages; //小图 可以是本地路径 也可以是网络地址 会自动判断
    
    
    for (id img in images) {
        [srcImages addObject:img];
        [thumbImages addObject:img];
    }
    
    textImageItem.location = location;
    [self addItemTop:textImageItem];
    
    
    //接着上传图片 和 请求服务器接口
    //请求完成之后 刷新整个界面
    [SVProgressHUD showWithStatus:@"正在发布..."];
    [OWNetworking HPOST:wh_appendingStr(wh_host, @"mobile/common/fileUpload1") parameters:@{@"key":@"123"} constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [images wh_each:^(UIImage *obj) {
            [formData appendPartWithFileData:UIImageJPEGRepresentation(obj, 0.1) name:@"files" fileName:@"head.jpg" mimeType:@"image/jpg"];
        }];
    } success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            NSString *url = [responseObject[@"data"] componentsJoinedByString:@","];
            [self uploadmomentWithTitle:text url:url addressInfo:location];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
        wh_Log(@"---%@",error);
    }];
}

- (void)uploadmomentWithTitle:(NSString *)title url:(NSString *)url addressInfo:(NSString *)location
{
    NSDictionary *par = @{
                          @"title":title,
                          @"isShadow":@(1),
                          @"url":url,
                          @"addressInfo":location
                          };
    [OWNetworking HPOST:wh_appendingStr(wh_host, @"mobile/discussion/addDiscussion") parameters:par success:^(id  _Nullable responseObject) {
        if ([responseObject[@"code"] intValue] == 200) {
            [SVProgressHUD showSuccessWithStatus:@"发布成功!"];
        }else{
            [SVProgressHUD showInfoWithStatus:responseObject[@"msg"]];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD showInfoWithStatus:@"请检查网络!"];
    }];
}

//发送视频 目前没有实现填写文字
//-(void)onSendVideo:(NSString *)text videoPath:(NSString *)videoPath screenShot:(UIImage *)screenShot
//{
//    OWVideoLineItem *videoItem = [[OWVideoLineItem alloc] init];
//    videoItem.itemId = 10000000; //随便设置一个 待服务器生成
//    videoItem.userId = 10018;
//    videoItem.userAvatar = @"http://file-cdn.datafans.net/avatar/1.jpeg";
//    videoItem.userNick = @"富二代";
//    videoItem.title = @"发表了";
//    videoItem.text = @"新年过节 哈哈"; //这里需要present一个界面 用户填入文字后再发送 场景和发图片一样
//    videoItem.location = @"广州";
//    
//    videoItem.localVideoPath = videoPath;
//    videoItem.videoUrl = @""; //网络路径
//    videoItem.thumbUrl = @"";
//    videoItem.thumbImage = screenShot; //如果thumbImage存在 优先使用thumbImage
//    
//    [self addItemTop:videoItem];
//    
//    //接着上传图片 和 请求服务器接口
//    //请求完成之后 刷新整个界面
//    
//}

@end
