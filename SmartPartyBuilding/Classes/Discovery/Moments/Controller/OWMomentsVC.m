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
        
        item.width = 100;
        item.height = 100;
        if (obj.addressInfo) item.location = obj.addressInfo;
        [self addItem:item];
    }];
    
//    OWTextImageLineItem *textImageItem = [[OWTextImageLineItem alloc] init];
//    textImageItem.itemId = 1;
//    textImageItem.userId = 10086;
//    textImageItem.userAvatar = @"http://file-cdn.datafans.net/avatar/1.jpeg";
//    textImageItem.userNick = @"Allen";
//    textImageItem.title = @"";
//    textImageItem.text = @"你是我的小苹果 小苹果 我爱你 就像老鼠爱大米 18680551720 [亲亲]";
//    
//    NSMutableArray *srcImages = [NSMutableArray array];
//    [srcImages addObject:@"http://106.14.171.197/static/201781/014b1c47-397b-452a-9f12-7e65f8513494.jpg"];
////    [srcImages addObject:@"http://106.14.171.197/static/201781/014b1c47-397b-452a-9f12-7e65f8513494.jpg"];
////    [srcImages addObject:@"http://106.14.171.197/static/201781/014b1c47-397b-452a-9f12-7e65f8513494.jpg"];
////    [srcImages addObject:@"http://106.14.171.197/static/201781/014b1c47-397b-452a-9f12-7e65f8513494.jpg"];
////    [srcImages addObject:@"http://106.14.171.197/static/201781/014b1c47-397b-452a-9f12-7e65f8513494.jpg"];
//    
//    
//    textImageItem.srcImages = srcImages;
//    
//    
//    NSMutableArray *thumbImages = [NSMutableArray array];
//    [thumbImages addObject:@"http://106.14.171.197/static/201781/014b1c47-397b-452a-9f12-7e65f8513494.jpg"];
////    [thumbImages addObject:@"http://106.14.171.197/static/201781/014b1c47-397b-452a-9f12-7e65f8513494.jpg"];
////    [thumbImages addObject:@"http://106.14.171.197/static/201781/014b1c47-397b-452a-9f12-7e65f8513494.jpg"];
////    [thumbImages addObject:@"http://106.14.171.197/static/201781/014b1c47-397b-452a-9f12-7e65f8513494.jpg"];
////    [thumbImages addObject:@"http://106.14.171.197/static/201781/014b1c47-397b-452a-9f12-7e65f8513494.jpg"];
//    textImageItem.thumbImages = thumbImages;
//    
//    
//    NSMutableArray *thumbPreviewImages = [NSMutableArray array];
//    [thumbPreviewImages addObject:@"http://106.14.171.197/static/201781/014b1c47-397b-452a-9f12-7e65f8513494.jpg"];
////    [thumbPreviewImages addObject:@"http://106.14.171.197/static/201781/014b1c47-397b-452a-9f12-7e65f8513494.jpg"];
////    [thumbPreviewImages addObject:@"http://106.14.171.197/static/201781/014b1c47-397b-452a-9f12-7e65f8513494.jpg"];
////    [thumbPreviewImages addObject:@"http://106.14.171.197/static/201781/014b1c47-397b-452a-9f12-7e65f8513494.jpg"];
////    [thumbPreviewImages addObject:@"http://106.14.171.197/static/201781/014b1c47-397b-452a-9f12-7e65f8513494.jpg"];
////    [thumbPreviewImages addObject:@"http://106.14.171.197/static/201781/014b1c47-397b-452a-9f12-7e65f8513494.jpg"];
//    textImageItem.thumbPreviewImages = thumbPreviewImages;
//    
//    
//    textImageItem.location = @"中国 • 广州";
//    textImageItem.ts = [[NSDate date] timeIntervalSince1970]*1000;
//    
//    
//    OWLineLikeItem *likeItem1_1 = [[OWLineLikeItem alloc] init];
//    likeItem1_1.userId = 10086;
//    likeItem1_1.userNick = @"Allen";
//    [textImageItem.likes addObject:likeItem1_1];
//    
//    
//    OWLineLikeItem *likeItem1_2 = [[OWLineLikeItem alloc] init];
//    likeItem1_2.userId = 10088;
//    likeItem1_2.userNick = @"奥巴马";
//    [textImageItem.likes addObject:likeItem1_2];
//    
//    
//    
//    OWLineCommentItem *commentItem1_1 = [[OWLineCommentItem alloc] init];
//    commentItem1_1.commentId = 10001;
//    commentItem1_1.userId = 10086;
//    commentItem1_1.userNick = @"习大大";
//    commentItem1_1.text = @"精彩 大家鼓掌";
//    [textImageItem.comments addObject:commentItem1_1];
//    
//    
//    OWLineCommentItem *commentItem1_2 = [[OWLineCommentItem alloc] init];
//    commentItem1_2.commentId = 10002;
//    commentItem1_2.userId = 10088;
//    commentItem1_2.userNick = @"奥巴马";
//    commentItem1_2.text = @"欢迎来到美利坚";
//    commentItem1_2.replyUserId = 10086;
//    commentItem1_2.replyUserNick = @"习大大";
//    [textImageItem.comments addObject:commentItem1_2];
//    
//    
//    OWLineCommentItem *commentItem1_3 = [[OWLineCommentItem alloc] init];
//    commentItem1_3.commentId = 10003;
//    commentItem1_3.userId = 10010;
//    commentItem1_3.userNick = @"神雕侠侣";
//    commentItem1_3.text = @"呵呵";
//    [textImageItem.comments addObject:commentItem1_3];
//    
//    [self addItem:textImageItem];
//    
//    
//    OWTextImageLineItem *textImageItem2 = [[OWTextImageLineItem alloc] init];
//    textImageItem2.itemId = 2;
//    textImageItem2.userId = 10088;
//    textImageItem2.userAvatar = @"http://file-cdn.datafans.net/avatar/2.jpg";
//    textImageItem2.userNick = @"奥巴马";
//    textImageItem2.title = @"发表了";
//    textImageItem2.text = @"京东JD.COM-专业的综合网上购物商城，销售超数万品牌、4020万种商品，http://jd.com 囊括家电、手机、电脑、服装、图书、母婴、个护、食品、旅游等13大品类。秉承客户为先的理念，京东所售商品为正品行货、全国联保、机打发票。@刘强东";
//    
//    NSMutableArray *srcImages2 = [NSMutableArray array];
//    [srcImages2 addObject:@"http://file-cdn.datafans.net/temp/20.jpg"];
////    [srcImages2 addObject:@"http://file-cdn.datafans.net/temp/21.jpg"];
////    [srcImages2 addObject:@"http://file-cdn.datafans.net/temp/22.jpg"];
////    [srcImages2 addObject:@"http://file-cdn.datafans.net/temp/23.jpg"];
//    textImageItem2.srcImages = srcImages2;
//    
//    
//    NSMutableArray *thumbImages2 = [NSMutableArray array];
//    [thumbImages2 addObject:@"http://file-cdn.datafans.net/temp/20.jpg_160x160.jpeg"];
////    [thumbImages2 addObject:@"http://file-cdn.datafans.net/temp/21.jpg_160x160.jpeg"];
////    [thumbImages2 addObject:@"http://file-cdn.datafans.net/temp/22.jpg_160x160.jpeg"];
////    [thumbImages2 addObject:@"http://file-cdn.datafans.net/temp/23.jpg_160x160.jpeg"];
//    textImageItem2.thumbImages = thumbImages2;
//    
//    
//    NSMutableArray *thumbPreviewImages2 = [NSMutableArray array];
//    [thumbPreviewImages2 addObject:@"http://file-cdn.datafans.net/temp/20.jpg_600x600.jpeg"];
////    [thumbPreviewImages2 addObject:@"http://file-cdn.datafans.net/temp/21.jpg_600x600.jpeg"];
////    [thumbPreviewImages2 addObject:@"http://file-cdn.datafans.net/temp/22.jpg_600x600.jpeg"];
////    [thumbPreviewImages2 addObject:@"http://file-cdn.datafans.net/temp/23.jpg_600x600.jpeg"];
//    textImageItem2.thumbPreviewImages = thumbPreviewImages2;
//    
//    OWLineLikeItem *likeItem2_1 = [[OWLineLikeItem alloc] init];
//    likeItem2_1.userId = 10086;
//    likeItem2_1.userNick = @"Allen";
//    [textImageItem2.likes addObject:likeItem2_1];
//    
//    
//    OWLineCommentItem *commentItem2_1 = [[OWLineCommentItem alloc] init];
//    commentItem2_1.commentId = 18789;
//    commentItem2_1.userId = 10088;
//    commentItem2_1.userNick = @"奥巴马";
//    commentItem2_1.text = @"欢迎来到美利坚";
//    commentItem2_1.replyUserId = 10086;
//    commentItem2_1.replyUserNick = @"习大大";
//    [textImageItem2.comments addObject:commentItem2_1];
//    
//    OWLineCommentItem *commentItem2_2 = [[OWLineCommentItem alloc] init];
//    commentItem2_2.commentId = 234657;
//    commentItem2_2.userId = 10010;
//    commentItem2_2.userNick = @"神雕侠侣";
//    commentItem2_2.text = @"大家好";
//    [textImageItem2.comments addObject:commentItem2_2];
//    
//    
//    [self addItem:textImageItem2];
//    
//    
//    
//    
//    OWTextImageLineItem *textImageItem3 = [[OWTextImageLineItem alloc] init];
//    textImageItem3.itemId = 3;
//    textImageItem3.userId = 10088;
//    textImageItem3.userAvatar = @"http://file-cdn.datafans.net/avatar/2.jpg";
//    textImageItem3.userNick = @"奥巴马";
//    textImageItem3.title = @"发表了";
//    textImageItem3.text = @"京东JD.COM-专业的综合网上购物商城";
//    
//    NSMutableArray *srcImages3 = [NSMutableArray array];
//    [srcImages3 addObject:@"http://106.14.171.197/static/201781/014b1c47-397b-452a-9f12-7e65f8513494.jpg"];
//    textImageItem3.srcImages = srcImages3;
//    
//    
//    NSMutableArray *thumbImages3 = [NSMutableArray array];
//    [thumbImages3 addObject:@"http://106.14.171.197/static/201781/014b1c47-397b-452a-9f12-7e65f8513494.jpg"];
//    textImageItem3.thumbImages = thumbImages3;
//    
//    
////    NSMutableArray *thumbPreviewImages3 = [NSMutableArray array];
////    [thumbPreviewImages3 addObject:@"http://106.14.171.197/static/201781/014b1c47-397b-452a-9f12-7e65f8513494.jpg"];
////    textImageItem3.thumbPreviewImages = thumbPreviewImages3;
//    
//    
//    textImageItem3.width = 50;
//    textImageItem3.height = 50;
//    
//    textImageItem3.location = @"广州信息港";
//    
//    OWLineCommentItem *commentItem3_1 = [[OWLineCommentItem alloc] init];
//    commentItem3_1.commentId = 78718789;
//    commentItem3_1.userId = 10010;
//    commentItem3_1.userNick = @"狄仁杰";
//    commentItem3_1.text = @"神探是我";
//    [textImageItem3.comments addObject:commentItem3_1];
//    
//    
//    
//    
//    [self addItem:textImageItem3];
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
    NSDictionary *userInfo = [OWTool getUserInfo];
    OWLineLikeItem *likeItem = [[OWLineLikeItem alloc] init];
    likeItem.userId = [userInfo[@"staffId"] integerValue];
    likeItem.userNick = userInfo[@"staffName"];
    [self addLikeItem:likeItem itemId:itemId];
    
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
