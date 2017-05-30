//
//  OWBaseTimeLineVC.h
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/17.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OWBaseTimeLineVC : UIViewController

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSUInteger coverWidth;
@property (nonatomic, assign) NSUInteger coverHeight;
@property (nonatomic, assign) NSUInteger userAvatarSize;

/** 结束上拉更多 */
-(void) endLoadMore;

/** 结束下拉刷新 */
-(void) endRefresh;

/** 点击封面上的用户头像 */
-(void) onClickHeaderUserAvatar;

/** 设置封面 */
-(void) setCover:(NSString *) url;

/** 设置封面上的用户头像 */
-(void) setUserAvatar:(NSString *) url;

/** 设置封面上的昵称 */
-(void) setUserNick:(NSString *)nick;

/** 设置用户签名 */
-(void) setUserSign:(NSString *)sign;

@end
