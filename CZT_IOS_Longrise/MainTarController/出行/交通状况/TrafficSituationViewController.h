//
//  TrafficSituationViewController.h
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/12/7.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "PublicViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

@interface TrafficSituationViewController : PublicViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>{
    BMKMapView* _mapView;
    //定位服务类
    BMKLocationService *_locService;
    UIButton *normalModeBtn;
    UIButton *luoPanModeBtn;
    
    //地理编码
    BMKGeoCodeSearch* _geocodesearch;
    UILabel *label1;//当前经纬度
    UILabel *label2;//当前地址
}

@end
