//
//  Util.h
//  KCKPLeader
//
//  Created by 程三 on 15/11/26.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Reachability.h"
@interface Util : NSObject

#pragma mark 获取屏幕宽度
+(CGFloat)getUIScreenWidth;

#pragma mark 获取屏幕高度
+(CGFloat)getUIScreenHeight;

#pragma mark 系统版本
+(float)getVersion;

#pragma mark 状态栏高度
+(int)getStatusBarHeight;

#pragma mark 导航栏高度
+(CGFloat)getnavigationBarHeight:(UINavigationController *)nav;

#pragma mark 导航栏高度和状态栏的总高度
+(CGFloat)getStatusBarAndnavigationBarHeight:(UINavigationController *)nav;

#pragma mark 加密
+(NSString *)encryption:(NSString *)content mark:(int)mark;

#pragma mark 图片缩放
+(UIImage*) originImage:(UIImage *)image scaleToSize:(CGSize)size;

#pragma mark 图片的旋转
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;

#pragma mark 根据格式获取当前时间
+(NSString *)getCurrentTimeByFormal:(NSString *)formal;

#pragma mark 获取图片的大小（单位为K）
+(NSNumber *)getImageBig:(UIImage *)image;

#pragma mark 获取设备名称
+(NSString *)getCurrentDeviceName;

#pragma mark 获取唯一表示符
+(NSString *)getIdentifierForVendor;

#pragma mark 返回key值
+(NSString *)getKey;

#pragma mark 获取网络状态 0:没有网 1:WI-FI 2:手机移动网
+(int)getNetState;

#pragma mark 将字典写入文件中
+(BOOL)DicWrite2File:(NSString *) dicPath fileName:(NSString *)fileName Dic:(NSDictionary *)dic;

#pragma mark 获取当前时间戳
+(long)getCurrentTime;

#pragma mark - 转json
+ (NSString*)objectToJson:(NSObject *)object;

#pragma mark 判断一个字符串是否全部为数字
+ (BOOL)isPureInt:(NSString *)string;

#pragma mark 设置UITextField距离左边的距离
+(void)setTextFieldLeftPadding:(UITextField *)textField forWidth:(CGFloat)leftWidth;
@end
