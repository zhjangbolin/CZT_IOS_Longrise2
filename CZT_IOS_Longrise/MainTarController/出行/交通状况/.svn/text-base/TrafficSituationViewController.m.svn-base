//
//  TrafficSituationViewController.m
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/12/7.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "TrafficSituationViewController.h"

@interface TrafficSituationViewController ()

@end

@implementation TrafficSituationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
        self.hidesBottomBarWhenPushed = YES;
        //self.isShowController = true;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _mapView = [[BMKMapView alloc] initWithFrame:self.view.frame];
    [self.view addSubview: _mapView];
    //初始化BMKLocationService
    _locService = [[BMKLocationService alloc]init];
    self.title = @"交通状况";
    //初始化地理编码类
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    
    [self startLocation:nil];
    // Do any additional setup after loading the view from its nib.
}


#pragma mark 单击回调方法
-(void)onClick:(UIButton *)btn
{
    if(nil == btn)
    {
        return;
    }
    if(normalModeBtn == btn)
    {
        [self startFollowing:nil];
        normalModeBtn.enabled = NO;
        luoPanModeBtn.enabled = YES;
        //普通模式
    }
    else if(luoPanModeBtn == btn)
    {
        //罗盘模式
        [self startFollowHeading:nil];
        normalModeBtn.enabled = YES;
        luoPanModeBtn.enabled = NO;
    }
}

//开始定位
-(void)startLocation:(id)sender
{
    NSLog(@"进入普通定位态");
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    [_mapView setTrafficEnabled:YES];
    
    [self startFollowing:nil];
}
//罗盘态
-(void)startFollowHeading:(id)sender
{
    NSLog(@"进入罗盘态");
    
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
    _mapView.showsUserLocation = YES;
    
}
//跟随态
-(void)startFollowing:(id)sender
{
    NSLog(@"进入跟随态");
    
    _mapView.showsUserLocation = NO;
    _mapView.userTrackingMode = BMKUserTrackingModeFollow;
    _mapView.showsUserLocation = YES;
    
}
//停止定位
-(void)stopLocation:(id)sender
{
    [_locService stopUserLocationService];
    _mapView.showsUserLocation = NO;
}

-(void)viewWillAppear:(BOOL)animated
{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    self.tabBarController.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _geocodesearch.delegate = nil; // 此处记得不用的时候需要置nil，否则影响内存的释放
    self.tabBarController.tabBar.hidden = NO;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [self stopLocation:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [_mapView updateLocationData:userLocation];
    //NSLog(@"heading is %@",userLocation.heading);
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //显示经纬度
    if(nil != label1)
    {
        label1.text = [NSString stringWithFormat:@"lat:%f,long:%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude];
    }
    
    [_mapView updateLocationData:userLocation];
    [self onClickReverseGeocode:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

#pragma mark 地理编码BMKGeoCodeSearchDelegate回调方法
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0)
    {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        item.coordinate = result.location;
        item.title = result.address;
        [_mapView addAnnotation:item];
        _mapView.centerCoordinate = result.location;
        NSString* titleStr;
        NSString* showmeg;
        titleStr = @"反向地理编码";
        showmeg = [NSString stringWithFormat:@"%@",item.title];
        
        if(label2 != nil)
        {
            label2.text = showmeg;
        }
    }
}

#pragma mark 将经纬度换算成具体地址
-(void)onClickReverseGeocode:(float)latitude longitude:(float) longitude
{
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    pt = (CLLocationCoordinate2D){latitude, longitude};
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
