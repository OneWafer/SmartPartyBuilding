//
//  OWUserTimeLineVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/5/19.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import "OWUserTimeLineVC.h"
#import "OWBaseUserLineItem.h"
#import "OWUserLineCellManager.h"
#import "OWBaseUserLineCell.h"
#import "OWTextImageUserLineCell.h"
#import "OWTextImageUserLineItem.h"


@interface OWUserTimeLineVC ()<OWBaseUserLineCellDelegate>

@property (nonatomic, strong) NSMutableArray *items;

@property (nonatomic, assign) NSUInteger currentDay;

@property (nonatomic, assign) NSUInteger currentMonth;

@property (nonatomic, assign) NSUInteger currentYear;

@end

@implementation OWUserTimeLineVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        _items = [NSMutableArray array];
        
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    OWBaseUserLineItem *item = [_items objectAtIndex:indexPath.row];
    OWBaseUserLineCell *typeCell = [self getCell:[item class]];
    return [typeCell getCellHeight:item];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OWBaseUserLineItem *item = [_items objectAtIndex:indexPath.row];
    
    OWBaseUserLineCell *typeCell = [self getCell:[item class]];
    
    NSString *reuseIdentifier = NSStringFromClass([typeCell class]);
    OWBaseUserLineCell *cell = [tableView dequeueReusableCellWithIdentifier: reuseIdentifier];
    if (cell == nil ) {
        cell = [[[typeCell class] alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }else{
        wh_Log(@"重用Cell: %@", reuseIdentifier);
    }
    
    
    cell.delegate = self;
    [cell updateWithItem:item];
    
    return cell;
}

#pragma mark - Method

- (OWBaseUserLineCell *) getCell:(Class)itemClass
{
    OWUserLineCellManager *manager = [OWUserLineCellManager sharedInstance];
    return [manager getCell:itemClass];
}


- (void)addItem:(OWBaseUserLineItem *)item
{
    
//    NSDate *date = [NSDate dateWithTimeIntervalSince1970:(item.ts/1000)];
//    NSCalendar* calendar = [NSCalendar currentCalendar];
//    NSDateComponents* components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:date];
//    NSInteger month = [components month];
//    NSInteger day = [components day];
//    NSInteger year = [components year];
    NSString *timestamp = [NSString stringWithFormat:@"%d",item.ts];
    NSTimeInterval interval = timestamp.length == 13 ? [timestamp doubleValue] / 1000.0f : [timestamp doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *dateComponent = [calendar components:unitFlags fromDate:date];
    
    NSInteger year = [dateComponent year];
    NSInteger month = [dateComponent month];
    NSInteger day = [dateComponent day];
    
    item.year = year;
    item.month = month;
    item.day = day;
    
    if (year == _currentYear && month == _currentMonth && day == _currentDay) {
        item.bShowTime = NO;
    }else{
        item.bShowTime = YES;
    }
    
    _currentDay = day;
    _currentMonth = month;
    _currentYear = year;
    
    wh_Log(@"%ld %ld %ld %d", (long)year, (long)month, (long)day, item.bShowTime);
    
    [_items addObject:item];
    [self.tableView reloadData];
}



- (void)onClickItem:(OWBaseUserLineItem *)item
{
    
}

@end
