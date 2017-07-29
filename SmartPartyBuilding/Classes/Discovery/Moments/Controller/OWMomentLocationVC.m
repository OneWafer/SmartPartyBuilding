//
//  OWMomentLocationVC.m
//  SmartPartyBuilding
//
//  Created by 王卫华 on 2017/7/27.
//  Copyright © 2017年 王卫华. All rights reserved.
//

#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "OWMomentLocationVC.h"
#import "OWMomLocationCell.h"

#define DefaultLocationTimeout 10
#define DefaultReGeocodeTimeout 5

@interface OWMomentLocationVC ()<AMapSearchDelegate,AMapLocationManagerDelegate>

@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;
@property (nonatomic, strong) NSMutableArray *locationList;

@end

@implementation OWMomentLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"所在位置";
    [self setupNavi];
    
    self.locationList = [NSMutableArray array];
    self.tableView.separatorStyle = NO;
    self.tableView.rowHeight = 50.0f;
    
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    
    [self initCompleteBlock];
    
    [self configLocationManager];
    [self locAction];
    
}

- (void)setupNavi
{
    wh_weakSelf(self);
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem wh_itemWithType:WHItemTypeLeft norTitle:@"取消" font:15.0f norColor:wh_norFontColor highColor:wh_norFontColor offset:0 actionHandler:^(UIButton *sender) {
        [weakself dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    
    [self.locationManager setDelegate:self];
    
    //设置期望定位精度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //设置允许在后台定位
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    
    //设置定位超时时间
    [self.locationManager setLocationTimeout:DefaultLocationTimeout];
    
    //设置逆地理超时时间
    [self.locationManager setReGeocodeTimeout:DefaultReGeocodeTimeout];
}


- (void)cleanUpAction
{
    //停止定位
    [self.locationManager stopUpdatingLocation];
    
    [self.locationManager setDelegate:nil];
}

- (void)locAction
{
    //进行单次定位请求
    [self.locationManager requestLocationWithReGeocode:NO completionBlock:self.completionBlock];
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0) return;
    
    //解析response获取POI信息，具体解析见 Demo
    [response.pois wh_each:^(AMapPOI *obj) {
        [self.locationList addObject:obj];
        wh_Log(@"--%@",obj.address);
    }];
    
    [self.tableView reloadData];
}

#pragma mark - Initialization

- (void)initCompleteBlock
{
    __weak OWMomentLocationVC *weakSelf = self;
    self.completionBlock = ^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error)
    {
        if (error != nil && error.code == AMapLocationErrorLocateFailed)
        {
            //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
            wh_Log(@"定位错误:{%ld - %@};", (long)error.code, error.localizedDescription);
            return;
        }
        else if (error != nil
                 && (error.code == AMapLocationErrorReGeocodeFailed
                     || error.code == AMapLocationErrorTimeOut
                     || error.code == AMapLocationErrorCannotFindHost
                     || error.code == AMapLocationErrorBadURL
                     || error.code == AMapLocationErrorNotConnectedToInternet
                     || error.code == AMapLocationErrorCannotConnectToHost))
        {
            //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
            wh_Log(@"逆地理错误:{%ld - %@};", (long)error.code, error.localizedDescription);
        }
        else if (error != nil && error.code == AMapLocationErrorRiskOfFakeLocation)
        {
            //存在虚拟定位的风险：此时location和regeocode没有返回值，不进行annotation的添加
            wh_Log(@"存在虚拟定位的风险:{%ld - %@};", (long)error.code, error.localizedDescription);
            return;
        }
        else
        {
            //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
        }
        
//        wh_Log(@"---%f--%f",location.coordinate.latitude, location.coordinate.longitude);
        
        AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
        
        request.location = [AMapGeoPoint locationWithLatitude:location.coordinate.latitude longitude:location.coordinate.longitude];
        /* 按照距离排序. */
        request.sortrule = 0;
        request.requireExtension = YES;
        
        [weakSelf.search AMapPOIAroundSearch:request];
    };
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.locationList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OWMomLocationCell *cell = [OWMomLocationCell cellWithTableView:tableView];
    cell.poi = self.locationList[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AMapPOI *poi = self.locationList[indexPath.row];
    wh_weakSelf(self);
    [self dismissViewControllerAnimated:YES completion:^{
        if (weakself.block) weakself.block(poi);
    }];
}

- (void)dealloc
{
    [self cleanUpAction];
    
    self.completionBlock = nil;
}

@end
