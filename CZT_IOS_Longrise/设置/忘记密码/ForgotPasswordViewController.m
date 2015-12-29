//
//  ForgotPasswordViewController.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 15/12/29.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "ForgotPasswordViewController.h"
#import "AFNetWorkService.h"
#import "CZT_IOS_Longrise.pch"
#import "Globle.h"
#import "FVCustomAlertView.h"

@interface ForgotPasswordViewController ()<UITextFieldDelegate>{
    NSTimer *timer;
    int count;
    FVCustomAlertView *alertView;
}

@end

@implementation ForgotPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    count = 120;
    _findPasswordButton.layer.masksToBounds = YES;
    _findPasswordButton.layer.cornerRadius = 7;
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)getVerifyBtnClicked:(id)sender {

    if (_phoneNumberTextField.text.length == 11) {
        alertView = [[FVCustomAlertView alloc] init];
        [alertView showAlertWithonView:self.view Width:100 height:100 contentView:nil cancelOnTouch:false Duration:-1];
        
        NSMutableDictionary *bean = [NSMutableDictionary dictionary];
        [bean setValue:_phoneNumberTextField.text forKey:@"mobilenumber"];
        [[Globle getInstance].service requestWithServiceIP:WXBaseServiceURL ServiceName:[NSString stringWithFormat:@"%@/appgetforgetpwdcode",appbase] params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
            BOOL isSucess = false;
            if (nil != result) {
                NSDictionary *bigDic = result;
                if ([bigDic[@"restate"]isEqualToString:@"1"]) {
                    
                    isSucess = true;
                    
                }else if ([bigDic[@"restate"]isEqualToString:@"-3"]){
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"获取验证码失败！" message:@"今日获取注册验证码次数已达上限,请明日继续获取" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
             
                }else{
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"获取验证码失败!" message:@"请检查网络是否连接!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                }
                
            }else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"获取验证码失败!" message:@"请检查网络是否连接!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                NSLog(@"没有请求到数据！");
            }
            
            if (isSucess) {
                
                //开始计时
                timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(nsTimerFinish) userInfo:nil repeats:YES];
            }
            [alertView dismiss];
            
        }];
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"获取验证码失败" message:@"您输入的手机号不正确！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    

}

#pragma mark 定时结束
-(void)nsTimerFinish
{
    if (count == 1)
    {
        count = 120;
        self.enumNumber.hidden = YES;
        [timer invalidate];
        self.getVerifyButton.userInteractionEnabled = YES;
        [self.getVerifyButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    else
    {
        count--;
        self.enumNumber.hidden = NO;
        NSString *title = [NSString stringWithFormat:@"剩余%d秒",count];
        self.enumNumber.text = title;
        self.getVerifyButton.userInteractionEnabled = NO;
    }
}

- (IBAction)findPasswordBtnClicked:(id)sender {
    
    if (_phoneNumberTextField.text.length == 11 && _userNameTextField.text.length > 0 && _verifyTextField.text.length > 0) {
        
        alertView = [[FVCustomAlertView alloc] init];
        [alertView showAlertWithonView:self.view Width:100 height:100 contentView:nil cancelOnTouch:false Duration:-1];
        
        _findPasswordButton.userInteractionEnabled = NO;
        
        NSMutableDictionary *bean = [NSMutableDictionary dictionary];
        [bean setValue:_userNameTextField.text forKey:@"userflag"];
        [bean setValue:@"" forKey:@"email"];
        [bean setValue:_phoneNumberTextField.text forKey:@"mobilephone"];
        [bean setValue:_verifyTextField.text forKey:@"code"];
        [bean setValue:@"0" forKey:@"flag"];
        
        [[Globle getInstance].service requestWithServiceIP:WXBaseServiceURL ServiceName:[NSString stringWithFormat:@"%@/appforgetpwd",appbase] params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
            if (nil != result) {
                NSDictionary *bigDic = result;
          //      NSLog(@"-----------%@",bigDic);
                if ([bigDic[@"restate"]isEqualToString:@"1"]) {
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请耐心等待新消息的发送！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                    _findPasswordButton.userInteractionEnabled = YES;
                }else{
                    
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"找回密码失败！" message:@"验证码不正确！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                    _findPasswordButton.userInteractionEnabled = YES;
                }
                
                
            }else{
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"找回密码失败!" message:@"请检查网络是否连接！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                _findPasswordButton.userInteractionEnabled = YES;
            }
            [alertView dismiss];
        }];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"找回密码失败!" message:@"信息未填完或者输入手机号有误!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
