//
//  PZQZViewController.m
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/11/28.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "PZQZViewController.h"
#import "TakePhoneFactory.h"
#import "PhoneViewController.h"

@interface PZQZViewController ()

@end

@implementation PZQZViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"拍照取证"];
    //设置按钮监听
    [self.moreCarCaseBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.oneCaseBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark 按钮点击回调方法
-(void)onClick:(UIButton *)btn
{
    myHUD = [[FVCustomAlertView alloc] init];
    [myHUD showAlertWithonView:self.view Width:100 height:100 contentView:nil cancelOnTouch:false Duration:0];
    [self startLoadData:btn];

}

#pragma mark 产生APP唯一案件号
-(void)startLoadData:(UIButton *)btn
{
    NSMutableDictionary *bean = [[NSMutableDictionary alloc] init];
    [bean setValue:[Globle getInstance].loadDataName forKey:@"username"];
    [bean setValue:[Globle getInstance].loadDataPass forKey:@"password"];
    
    NSString *tempStr = kckpzcslrest;
    [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].serviceURL ServiceName:[tempStr stringByAppendingString:@"/kckpCreateAppCaseNo"] params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
            [self loadFinish:result view:btn];
            if(nil != myHUD)
            {
                [myHUD dismiss];
            }
    } ];
    
}

#pragma mark 数据加载完成
-(void)loadFinish:(id)result view:(UIButton *)btn
{
    NSString *string = nil;
    BOOL sucess = false;
    NSDictionary *dic = result;
    if(nil == result)
    {
        string = @"数据加载失败,请检查网络。";
    }
    else
    {
        NSString *restate = [dic objectForKey:@"restate"];
        if([@"0" isEqualToString:restate])
        {
            sucess = true;
        }
        else
        {
            //失败
            string = (NSString *)[dic objectForKey:@"redes"];
        }

    }
    
    if(sucess)
    {
        PhoneViewController *phoneController = nil;
        
        NSDictionary *data = [dic objectForKey:@"data"];
        NSString *appcaseno =[data objectForKey:@"appcaseno"];
        
        //获取通知对象
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:appcaseno forKey:@"appcaseno"];
        
        if(self.oneCaseBtn == btn)
        {
            [dic setValue:@"1" forKey:@"type"];
            phoneController = [TakePhoneFactory createPhoneViewController:1];
        }
        else if(self.moreCarCaseBtn == btn)
        {
            [dic setValue:@"2" forKey:@"type"];
            phoneController = [TakePhoneFactory createPhoneViewController:2];
        }
        //发送通知，将事故类型和报案号发送到事故步骤页面，定责用到
        NSString *name = NotificationNameForCaseType;
        [center postNotificationName:name object:nil userInfo:dic];
        
        phoneController.appcaseno = appcaseno;
        [self.navigationController pushViewController:phoneController animated:YES];

    }
    else
    {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
        // Configure for text only and offset down
        hud.mode = MBProgressHUDModeText;
        hud.labelText = string;
        hud.margin = 20.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hide:YES afterDelay:3];

    }
}

@end
