//
//  OWUserMomentsVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/19.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWUserMomentsVC.h"
#import "OWTextImageUserLineItem.h"
#import "OWTool.h"

@interface OWUserMomentsVC ()

@end

@implementation OWUserMomentsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
    [self setHeader];
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
    OWTextImageUserLineItem *item = [[OWTextImageUserLineItem alloc] init];
    item.itemId = 1111;
    item.ts = 1444902955586;
    item.cover = @"http://file-cdn.datafans.net/temp/11.jpg_200x200.jpeg";
    item.photoCount = 5;
    item.text = @"我说你二你就二";
    [self addItem:item];
    
    
    OWTextImageUserLineItem *item2 = [[OWTextImageUserLineItem alloc] init];
    item2.itemId = 11222;
    item2.ts = 1444902951586;
    item2.text = @"阿里巴巴（1688.com）是全球企业间电子商务的著名品牌，为数千万网商提供海量商机信息和便捷安全的在线交易市场，也是商人们以商会友、真实互动的社区平台 ...";
    
    [self addItem:item2];
    
    
    OWTextImageUserLineItem *item3 = [[OWTextImageUserLineItem alloc] init];
    item3.itemId = 22221111;
    item3.ts = 1444102855586;
    item3.cover = @"http://file-cdn.datafans.net/temp/15.jpg_200x200.jpeg";
    item3.photoCount = 8;
    [self addItem:item3];
    
    
    OWTextImageUserLineItem *item4 = [[OWTextImageUserLineItem alloc] init];
    item4.itemId = 7771111;
    item4.ts = 1442912955586;
    item4.cover = @"http://file-cdn.datafans.net/temp/19.jpg_200x200.jpeg";
    item4.photoCount = 6;
    [self addItem:item4];
    
    
    
    OWTextImageUserLineItem *item5 = [[OWTextImageUserLineItem alloc] init];
    item5.itemId = 9991111;
    item5.ts = 1442912945586;
    item5.cover = @"http://file-cdn.datafans.net/temp/14.jpg_200x200.jpeg";
    item5.photoCount = 2;
    item5.text = @"京东JD.COM-专业的综合网上购物商城，销售超数万品牌、4020万种商品，http://jd.com 囊括家电、手机、电脑、服装、图书、母婴、个护、食品、旅游等13大品类。秉承客户为先的理念，京东所售商品为正品行货、全国联保、机打发票。@刘强东";
    [self addItem:item5];
}



-(void) refresh
{
    
    dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [self endRefresh];
    });
}


-(void) loadMore
{
    dispatch_time_t time=dispatch_time(DISPATCH_TIME_NOW, 1*NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [self endLoadMore];
    });
}



- (void)onClickItem:(OWBaseUserLineItem *)item
{
    wh_Log(@"click item: %lld", item.itemId);
}

@end
