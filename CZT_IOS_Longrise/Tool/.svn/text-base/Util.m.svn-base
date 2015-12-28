//
//  Util.m
//  KCKPLeader
//
//  Created by 程三 on 15/11/26.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "Util.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@implementation Util

#pragma mark 获取屏幕宽度
+(CGFloat)getUIScreenWidth
{
    return [UIScreen mainScreen].bounds.size.width;
}
#pragma mark 获取屏幕高度
+(CGFloat)getUIScreenHeight
{
    return [UIScreen mainScreen].bounds.size.height;
}
#pragma mark 系统版本
+(float)getVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
}
#pragma mark 状态栏高度
+(int)getStatusBarHeight
{
    return [[UIApplication sharedApplication] statusBarFrame].size.height;
}

#pragma mark 导航栏高度
+(CGFloat)getnavigationBarHeight:(UINavigationController *)nav
{
    if(nil == nav)
    {
        return 0;
    }
    return nav.navigationBar.frame.size.height;
}

#pragma mark 导航栏高度和状态栏的总高度
+(CGFloat)getStatusBarAndnavigationBarHeight:(UINavigationController *)nav
{
    if(nil == nav)
    {
        return 0;
    }
    
    return nav.navigationBar.frame.size.height + [[UIApplication sharedApplication] statusBarFrame].size.height;
}

#pragma mark 加密
+(NSString *)encryption:(NSString *)content mark:(int)mark
{
    if(nil == content)
    {
        return nil;
    }
    if(mark == 0)
    {
        return @"F11351A8B0D7483AEBCE6CBD7679F33A";
    }
    else
    {
        return @"7264DF191EDAE19BAE2BFB131C4A2E9E";
    }
}

#pragma mark 图片缩放
+(UIImage*) originImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

#pragma mark 图片的旋转
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation
{
    /*
     typedef enum {
     UIImageOrientationUp,
     UIImageOrientationDown ,   // 180 deg rotation
     UIImageOrientationLeft ,   // 90 deg CW
     UIImageOrientationRight ,   // 90 deg CCW
     UIImageOrientationUpMirrored ,    // as above but image mirrored along
     // other axis. horizontal flip
     UIImageOrientationDownMirrored ,  // horizontal flip
     UIImageOrientationLeftMirrored ,  // vertical flip
     UIImageOrientationRightMirrored , // vertical flip
     } UIImageOrientation;
     */
    
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case UIImageOrientationDown:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    return newPic;
}

#pragma mark 根据格式获取当前时间
+(NSString *)getCurrentTimeByFormal:(NSString *)formal
{
    NSString *time = nil;
    if(nil != formal && ![@"" isEqualToString:formal])
    {
        NSDateFormatter *formateter = [[NSDateFormatter alloc] init];
        [formateter setDateFormat:formal];
        time = [formateter stringFromDate:[NSDate date]];
    }
    return time;
}

#pragma mark 获取图片的大小（单位为K）
+(NSNumber *)getImageBig:(UIImage *)image
{
    if(image == nil)
    {
        return nil;
    }
    return [[NSNumber alloc] initWithDouble:UIImagePNGRepresentation(image).length/1000];
}

#pragma mark 获取设备名称
+(NSString *)getCurrentDeviceName
{
    return [UIDevice currentDevice].name;
}

#pragma mark 获取唯一表示符
+(NSString *)getIdentifierForVendor
{
    return [[UIDevice currentDevice].identifierForVendor UUIDString];
}

#pragma mark 返回key值
+(NSString *)getKey
{
    return @"s(p7~;W^";
}

#pragma mark 获取网络状态 0:没有网 1:WI-FI 2:手机移动网
+(int)getNetState
{
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    // 3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable)
    {
        // 有wifi
        return 1;
    }
    else if ([conn currentReachabilityStatus] != NotReachable)
    {
        // 没有使用wifi, 使用手机自带网络进行上网
        return 2;
    }
    else
    {
        // 没有网络
        return 0;
    }

}

#pragma mark 将字典写入文件中
+(BOOL)DicWrite2File:(NSString *) dicPath fileName:(NSString *)fileName Dic:(NSDictionary *)dic
{
    BOOL b = false;
    if(dicPath == nil || [@"" isEqualToString:dicPath] || dic == nil || fileName == nil || [@"" isEqualToString:fileName])
    {
        return b;
    }
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断目录是否存在
    if(![fileManager fileExistsAtPath:dicPath])
    {
        //不存在就创建
        BOOL ceaterSuccess = [fileManager createDirectoryAtPath:dicPath withIntermediateDirectories:YES attributes:nil error:NULL];
        if(!ceaterSuccess)
        {
            return b;
        }
    }
    
    NSString *fullPath = [dicPath stringByAppendingPathComponent:fileName];
    //判断文件是否存在
    if([fileManager fileExistsAtPath:fullPath])
    {
        //存在删除
        BOOL delSuccess = [fileManager removeItemAtPath:fullPath error:nil];
        if(!delSuccess)
        {
            return b;
        }
    }
    
    //创建文件
    BOOL createBool = [fileManager createFileAtPath:fullPath contents:nil attributes:nil];
    if(!createBool)
    {
        return b;
    }
    
    //写入
    b = [dic writeToFile:fullPath atomically:YES];
    
    return b;

}

#pragma mark 获取当前时间戳
+(long)getCurrentTime
{
    NSDate *localDate = [NSDate date]; //获取当前时间
    return (long)[localDate timeIntervalSince1970];
}

#pragma mark - 转JSON
+ (NSString*)objectToJson:(NSObject *)object
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

#pragma mark 判断一个字符串是否全部为数字
+ (BOOL)isPureInt:(NSString *)string
{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

#pragma mark 设置UITextField距离左边的距离
+(void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth
{
    CGRect frame = textField.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftview;
}
@end
