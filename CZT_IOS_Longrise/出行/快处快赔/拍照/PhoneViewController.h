//
//  PhoneViewController.h
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/11/28.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "PublicViewController.h"
#import "Globle.h"
#import "FVCustomAlertView.h"
#import "FinishViewController.h"

@interface PhoneViewController : PublicViewController<UIAlertViewDelegate>
{
    NSMutableDictionary *tempDic;
    UIAlertView *alert1;
    FVCustomAlertView *hud;
}
@property(nonatomic,copy)NSString *appcaseno;

#pragma mark 发送数据
-(void)sendPhoneInfo:(NSMutableDictionary *)dic;
#pragma mark 取证完成
-(void)zdsubmitcaseimageisover:(NSMutableDictionary *)dic;
#pragma mark 照片没有拍摄完整提示
-(void)showNoticeAboutImage;
@end
