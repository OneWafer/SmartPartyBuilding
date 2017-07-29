//
//  OWTimeLineVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <LCActionSheet.h>
#import <TZImagePickerController.h>
#import "OWTimeLineVC.h"
#import "OWLineCellManager.h"
#import "OWBaseLineCell.h"
#import "OWBaseLineItem.h"
#import "OWLineCommentItem.h"
#import "OWCommentInputView.h"
#import "OWImagesSendVC.h"
#import "OWVideoCaptureVC.h"
#import "OWLineLikeItem.h"

@interface OWTimeLineVC ()<OWLineCellDelegate, OWCommentInputViewDelegate, TZImagePickerControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, OWImagesSendVCDelegate, OWVideoCaptureVCDelegate>


@property (strong, nonatomic) OWCommentInputView *commentInputView;


@property (assign, nonatomic) long long currentItemId;

@property (nonatomic, strong) UIImagePickerController *pickerController;

@end

@implementation OWTimeLineVC

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _items = [NSMutableArray array];
        
        _itemDic = [NSMutableDictionary dictionary];
        
        _commentDic = [NSMutableDictionary dictionary];
        
    }
    return self;
}





- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initCommentInputView];
    [self setupNavi];
}






-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
    [_commentInputView addNotify];
    
    [_commentInputView addObserver];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_commentInputView removeNotify];
    
    [_commentInputView removeObserver];
}




- (void)setupNavi
{
    wh_weakSelf(self);
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem wh_itemWithType:WHItemTypeRight norImage:@"discovery_camera" highImage:@"" offset:0 actionHandler:^(UIButton *sender) {
        [weakself onClickCamera:sender];
    }];
    
    UILongPressGestureRecognizer *recognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(onLongPressCamera:)];
    [self.navigationItem.rightBarButtonItem.customView addGestureRecognizer:recognizer];
}


-(void) onLongPressCamera:(UIGestureRecognizer *) gesture
{
    OWImagesSendVC *controller = [[OWImagesSendVC alloc] initWithImages:nil];
    controller.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navController animated:YES completion:nil];
    
}


-(void) initCommentInputView
{
    if (_commentInputView == nil) {
        _commentInputView = [[OWCommentInputView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _commentInputView.hidden = YES;
        _commentInputView.delegate = self;
        [self.view addSubview:_commentInputView];
    }
    
}



-(void) onClickCamera:(id) sender
{
    wh_weakSelf(self);
    LCActionSheet *actionSheet = [LCActionSheet sheetWithTitle:nil cancelButtonTitle:@"取消" clicked:^(LCActionSheet * _Nonnull actionSheet, NSInteger buttonIndex) {
        
        switch (buttonIndex) {
            case 1:
                [weakself takePhoto];
                break;
            case 2:
                [weakself pickFromAlbum];
                break;
            default:
                break;
        }
        
    } otherButtonTitleArray:@[@"拍照", @"从相册选取"]];
    [actionSheet show];
    
}


-(void) captureViedo
{
    OWVideoCaptureVC *controller = [[OWVideoCaptureVC alloc] init];
    controller.delegate = self;
    [self presentViewController:controller animated:YES completion:^{
        
    }];
    
}


-(void) takePhoto
{
    _pickerController = [[UIImagePickerController alloc] init];
    _pickerController.delegate = self;
    _pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:_pickerController animated:YES completion:nil];
}

-(void) pickFromAlbum
{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    imagePickerVc.allowPickingVideo = NO;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _items.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWBaseLineItem *item = [_items objectAtIndex:indexPath.row];
    OWBaseLineCell *typeCell = [self getCell:[item class]];
    return [typeCell getReuseableCellHeight:item];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OWBaseLineItem *item = [_items objectAtIndex:indexPath.row];
    OWBaseLineCell *typeCell = [self getCell:[item class]];
    
    NSString *reuseIdentifier = NSStringFromClass([typeCell class]);
    OWBaseLineCell *cell = [tableView dequeueReusableCellWithIdentifier: reuseIdentifier];
    if (cell == nil ) {
        cell = [[[typeCell class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }else{
        wh_Log(@"重用Cell: %@", reuseIdentifier);
    }
    
    cell.delegate = self;
    
    cell.separatorInset = UIEdgeInsetsZero;
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
    [cell updateWithItem:item];
    
    return cell;
}


#pragma mark - TabelViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击所有cell空白地方 隐藏toolbar
    NSInteger rows =  [tableView numberOfRowsInSection:0];
    for (int row = 0; row < rows; row++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        OWBaseLineCell *cell  = (OWBaseLineCell *)[tableView cellForRowAtIndexPath:indexPath];
        [cell hideLikeCommentToolbar];
    }
}


#pragma mark - Method

- (OWBaseLineCell *) getCell:(Class)itemClass
{
    OWLineCellManager *manager = [OWLineCellManager sharedInstance];
    return [manager getCell:itemClass];
}

- (void)addItem:(OWBaseLineItem *)item
{
    [self insertItem:item index:_items.count];
}

- (void) addItemTop:(OWBaseLineItem *) item
{
    [self insertItem:item index:0];
}

- (void) insertItem:(OWBaseLineItem *) item index:(NSUInteger)index
{
    [self genLikeAttrString:item];
    [self genCommentAttrString:item];
    
    [_items insertObject:item atIndex:index];
    
    
    [_itemDic setObject:item forKey:[NSNumber numberWithLongLong:item.itemId]];
    
    [self.tableView reloadData];
}


- (void)deleteItem:(long long)itemId
{
    OWBaseLineItem *item = [self getItem:itemId];
    [_items removeObject:item];
    [_itemDic removeObjectForKey:[NSNumber numberWithLongLong:item.itemId]];
}

-(OWBaseLineItem *) getItem:(long long) itemId
{
    return [_itemDic objectForKey:[NSNumber numberWithLongLong:itemId]];
    
}

-(void)addLikeItem:(OWLineLikeItem *)likeItem itemId:(long long)itemId
{
    OWBaseLineItem *item = [self getItem:itemId];
    [item.likes insertObject:likeItem atIndex:0];
    
    item.likesStr = nil;
    item.cellHeight = 0;
    
    [self genLikeAttrString:item];
    
    [self.tableView reloadData];
}


-(void)addCommentItem:(OWLineCommentItem *)commentItem itemId:(long long)itemId replyCommentId:(long long)replyCommentId

{
    OWBaseLineItem *item = [self getItem:itemId];
    [item.comments addObject:commentItem];
    
    if (replyCommentId > 0) {
        OWLineCommentItem *replyCommentItem = [self getCommentItem:replyCommentId];
        commentItem.replyUserId = replyCommentItem.userId;
        commentItem.replyUserNick = replyCommentItem.userNick;
    }
    
    item.cellHeight = 0;
    [self genCommentAttrString:item];
    [self.tableView reloadData];
    
}

-(OWLineCommentItem *)getCommentItem:(long long)commentId
{
    return [_commentDic objectForKey:[NSNumber numberWithLongLong:commentId]];
}





#pragma mark - DFLineCellDelegate

-(void)onComment:(long long)itemId
{
    _currentItemId = itemId;
    
    _commentInputView.commentId = 0;
    
    _commentInputView.hidden = NO;
    
    [_commentInputView show];
}


-(void)onLike:(long long)itemId
{
    
}

-(void)onClickUser:(NSUInteger)userId
{
    
}


-(void)onClickComment:(long long)commentId itemId:(long long)itemId
{
    
    _currentItemId = itemId;
    
    _commentInputView.hidden = NO;
    
    _commentInputView.commentId = commentId;
    
    [_commentInputView show];
    
    OWLineCommentItem *comment = [_commentDic objectForKey:[NSNumber numberWithLongLong:commentId]];
    [_commentInputView setPlaceHolder:[NSString stringWithFormat:@"  回复: %@", comment.userNick]];
    
}


-(void)onCommentCreate:(long long)commentId text:(NSString *)text
{
    [self onCommentCreate:commentId text:text itemId:_currentItemId];
}


-(void)onCommentCreate:(long long)commentId text:(NSString *)text itemId:(long long) itemId
{
    
}





-(void) genLikeAttrString:(OWBaseLineItem *) item
{
    if (item.likes.count == 0) {
        return;
    }
    
    if (item.likesStr == nil) {
        NSMutableArray *likes = item.likes;
        NSString *result = @"";
        
        for (int i=0; i<likes.count;i++) {
            OWLineLikeItem *like = [likes objectAtIndex:i];
            if (i == 0) {
                result = [NSString stringWithFormat:@"%@",like.userNick];
            }else{
                result = [NSString stringWithFormat:@"%@, %@", result, like.userNick];
            }
        }
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc]initWithString:result];
        NSUInteger position = 0;
        for (int i=0; i<likes.count;i++) {
            OWLineLikeItem *like = [likes objectAtIndex:i];
            [attrStr addAttribute:NSLinkAttributeName value:[NSString stringWithFormat:@"%lu", (unsigned long)like.userId] range:NSMakeRange(position, like.userNick.length)];
            position += like.userNick.length+2;
        }
        
        item.likesStr = attrStr;
    }
    
}

-(void) genCommentAttrString:(OWBaseLineItem *)item
{
    NSMutableArray *comments = item.comments;
    
    [item.commentStrArray removeAllObjects];
    
    for (int i=0; i<comments.count;i++) {
        OWLineCommentItem *comment = [comments objectAtIndex:i];
        [_commentDic setObject:comment forKey:[NSNumber numberWithLongLong:comment.commentId]];
        
        NSString *resultStr;
        if (comment.replyUserId == 0) {
            resultStr = [NSString stringWithFormat:@"%@: %@",comment.userNick, comment.text];
        }else{
            resultStr = [NSString stringWithFormat:@"%@回复%@: %@",comment.userNick, comment.replyUserNick, comment.text];
        }
        
        NSMutableAttributedString *commentStr = [[NSMutableAttributedString alloc]initWithString:resultStr];
        if (comment.replyUserId == 0) {
            [commentStr addAttribute:NSLinkAttributeName value:[NSString stringWithFormat:@"%lu", (unsigned long)comment.userId] range:NSMakeRange(0, comment.userNick.length)];
        }else{
            NSUInteger localPos = 0;
            [commentStr addAttribute:NSLinkAttributeName value:[NSString stringWithFormat:@"%lu", (unsigned long)comment.userId] range:NSMakeRange(localPos, comment.userNick.length)];
            localPos += comment.userNick.length + 2;
            [commentStr addAttribute:NSLinkAttributeName value:[NSString stringWithFormat:@"%lu", (unsigned long)comment.replyUserId] range:NSMakeRange(localPos, comment.replyUserNick.length)];
        }
        
        wh_Log(@"ffff: %@", resultStr);
        
        [item.commentStrArray addObject:commentStr];
    }
}


#pragma mark - TZImagePickerControllerDelegate

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    wh_Log(@"%@", photos);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        OWImagesSendVC *controller = [[OWImagesSendVC alloc] initWithImages:photos];
        controller.delegate = self;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:navController animated:YES completion:nil];
    });
    
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [_pickerController dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    
    OWImagesSendVC *controller = [[OWImagesSendVC alloc] initWithImages:@[image]];
    controller.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:navController animated:YES completion:nil];
    
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [_pickerController dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - DFImagesSendViewControllerDelegate

-(void)onSendTextImage:(NSString *)text images:(NSArray *)images  location:(NSString *)location
{
    
}

#pragma mark - DFVideoCaptureControllerDelegate
-(void)onCaptureVideo:(NSString *)filePath screenShot:(UIImage *)screenShot
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self onSendVideo:@"" videoPath:filePath screenShot:screenShot];
    });
}

-(void)onSendVideo:(NSString *)text videoPath:(NSString *)videoPath screenShot:(UIImage *)screenShot
{
    
}

@end
