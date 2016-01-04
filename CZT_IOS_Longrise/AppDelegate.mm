//
//  AppDelegate.m
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/11/27.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSLog(@"didFinishLaunchingWithOptions");
    self.window.backgroundColor = [UIColor whiteColor];
    // 要使用百度地图，请先启动BaiduMapManager
    BMKMapManager *_mapManager = [[BMKMapManager alloc]init];
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:@"NqXG9y1UIxRz6X2Ol24SC11u"  generalDelegate:nil];
    if (!ret)
    {
        NSLog(@"manager 启动失败");
    }
    
    //添加标记值，用来标记是否加载菜单
    [UserDefaultsUtil saveNSUserDefaultsForObject:@"1" forKey:@"isLoadMenu"];
    
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    //非4寸屏
    if(ScreenHeight != 568){
        myDelegate.autoSizeScaleX = ScreenWidth/320;
        myDelegate.autoSizeScaleY = ScreenHeight/568;
    }
    //4寸屏
    else{
        myDelegate.autoSizeScaleX = 1.0;
        myDelegate.autoSizeScaleY = 1.0;
    }
    
    //判断是非是第一次启动APP
    BOOL isSecond = [UserDefaultsUtil getDataForKey:@"isSecond"];
    if(!isSecond)
    {
        //设置指示器的颜色
        UIPageControl *pageControl = [UIPageControl appearance];
        pageControl.pageIndicatorTintColor = [UIColor colorWithRed:223/255.0 green:223/255.0 blue:223/255.0 alpha:1];
        pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:51/255.0 green:151/255.0 blue:241/255.0 alpha:1];
        pageControl.backgroundColor = [UIColor whiteColor];
        
        [UserDefaultsUtil saveNSUserDefaultsForBOOL:YES forKey:@"isSecond"];
        
        UIStoryboard *loginStoryboard=[UIStoryboard storyboardWithName:@"FirstGuide" bundle:nil];
        self.window.rootViewController=[loginStoryboard instantiateInitialViewController];
    }
    else
    {
        UIStoryboard *loginStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.window.rootViewController=[loginStoryboard instantiateInitialViewController];
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    NSLog(@"applicationWillResignActive");
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSLog(@"applicationDidEnterBackground");
    [self sendLoadNotice:@"1"];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    NSLog(@"applicationWillEnterForeground");
    [self sendLoadNotice:@"0"];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    NSLog(@"applicationDidBecomeActive");
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    NSLog(@"applicationWillTerminate");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//storyBoard view自动适配
+ (void)storyBoradAutoLay:(UIView *)allView
{
    for (UIView *temp in allView.subviews) {
        temp.frame = CGRectMake1(temp.frame.origin.x, temp.frame.origin.y, temp.frame.size.width, temp.frame.size.height);
        for (UIView *temp1 in temp.subviews) {
            temp1.frame = CGRectMake1(temp1.frame.origin.x, temp1.frame.origin.y, temp1.frame.size.width, temp1.frame.size.height);
        }
    }
}

#pragma mark 发送菜单更新的通知
-(void)sendLoadNotice:(NSString *)str
{
    
    //0:加载 1:停止加载
    NSString *name = NotificationNameForLoadMenu;
    //获取通知对象
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:name object:str];

}

CG_INLINE CGRect//注意：这里的代码要放在.m文件最下面的位置
CGRectMake1(CGFloat x, CGFloat y, CGFloat width, CGFloat height)
{
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    CGRect rect;
    rect.origin.x = x * myDelegate.autoSizeScaleX;
    rect.origin.y = y * myDelegate.autoSizeScaleY;
    rect.size.width = width * myDelegate.autoSizeScaleX;
    rect.size.height = height * myDelegate.autoSizeScaleY;
    return rect;
}
@end
