//
//  AppDelegate.h
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/11/27.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import "CZT_IOS_Longrise.pch"
#import "UserDefaultsUtil.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property float autoSizeScaleX;//屏幕横向比例
@property float autoSizeScaleY;//屏幕纵向比例
//按屏幕比例适配的类方法
+ (void)storyBoradAutoLay:(UIView *)allView;
@end

