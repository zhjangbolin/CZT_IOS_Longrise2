//
//  HomeViewController.h
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/11/27.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginViewController.h"
#import "Util.h"
#import "UIViewExt.h"
#import "UISelectListView.h"
#import "MJRefresh.h"
#import "HomeTableViewCell.h"
#import "UserDefaultsUtil.h"
#import "FVCustomAlertView.h"

#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件

#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件

#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件

#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件

#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件

@interface HomeViewController : BaseViewController<LoginControllerClose,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,UISelectListViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    //定位服务类
    BMKLocationService *_locService;
    //地理编码
    BMKGeoCodeSearch* _geocodesearch;
    //位置选择
    UISelectListView *citySelectView;
    //天气和气温
    UIButton *weatherAndtemp;
    FVCustomAlertView *hud;
    //本地菜单信息
    //NSDictionary *localMenuInfo;
    NSArray *menuFirstArray;
}
@property (strong, nonatomic) UITableView *hometabView;
@end
