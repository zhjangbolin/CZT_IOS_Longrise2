//
//  BaseViewController.m
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/11/27.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "BaseViewController.h"
#import "CZT_IOS_Longrise.pch"
#import "UIViewExt.h"
#import "Util.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
    self.conn = [Reachability reachabilityForInternetConnection];
    [self.conn startNotifier];
}

- (void)dealloc
{
    [self.conn stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)networkStateChange
{
    [self checkNetworkState];
}

- (void)checkNetworkState
{
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    NSString *string = nil;
    // 3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable)
    {
        // 有wifi
    }
    else if ([conn currentReachabilityStatus] != NotReachable)
    {
        // 没有使用wifi, 使用手机自带网络进行上网
    }
    else
    {
        // 没有网络
        string = @"没有网络";
    }
    
    if(nil != string && [@"" isEqualToString:string])
    {
        MBProgressHUD *myhud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        
        // Configure for text only and offset down
        myhud.mode = MBProgressHUDModeText;
        myhud.labelText = string;
        myhud.margin = 20.f;
        myhud.removeFromSuperViewOnHide = YES;
        
        [myhud hide:YES afterDelay:3];
    }
}
@end

// 用WIFI
// [wifi currentReachabilityStatus] != NotReachable
// [conn currentReachabilityStatus] != NotReachable

// 没有用WIFI, 只用了手机网络
// [wifi currentReachabilityStatus] == NotReachable
// [conn currentReachabilityStatus] != NotReachable

// 没有网络
// [wifi currentReachabilityStatus] == NotReachable
// [conn currentReachabilityStatus] == NotReachable
