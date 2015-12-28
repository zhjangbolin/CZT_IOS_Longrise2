//
//  RegViewController.m
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/12/1.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "RegViewController.h"

@interface RegViewController ()

@end

@implementation RegViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    isAgree = true;
    count = 120;
    isRegSucess = false;
    
    [super setTitle:@"注册"];
    
    CGFloat left = 10;
    //设置代理
    self.userName.delegate = self;
    [Util setTextFieldLeftPadding:self.userName forWidth:left];
    self.phoneNum.delegate = self;
    [Util setTextFieldLeftPadding:self.phoneNum forWidth:left];
    self.verificationCode.delegate = self;
    [Util setTextFieldLeftPadding:self.verificationCode forWidth:left];
    self.passWordText.delegate = self;
    [Util setTextFieldLeftPadding:self.passWordText forWidth:left];
    self.againPasswordText.delegate = self;
    [Util setTextFieldLeftPadding:self.againPasswordText forWidth:left];
    
    [self.getCodeBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.agreementBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.okBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

//页面消失，进入后台不显示该页面，关闭定时器
-(void)viewDidDisappear:(BOOL)animated
{
    if(nil != timer)
    {
        //关闭定时器
        [timer setFireDate:[NSDate distantFuture]];
    }
    
    if(!isRegSucess)
    {
        if(nil != self.regViewControllerDelegate)
        {
            [self.regViewControllerDelegate regViewControllerClose:self sucess:false];
        }
    }
}

#pragma mark 点击回调事件
-(void)onClick:(UIButton *)btn
{
    if(btn == self.getCodeBtn)
    {
        if(nil != self.phoneNum)
        {
            [self.phoneNum resignFirstResponder];
        }
        //判断手机号是否为空并且为11位
        if(nil == phoneNumStr || [@"" isEqualToString:phoneNumStr] || ![Util isPureInt:phoneNumStr]|| phoneNumStr.length != 11)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您输入的号码有误。" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
            [alert show];
            return;
        }
        self.getCodeBtn.enabled = NO;
        //请求验证码
        [self appgetvalidcode];
    }
    else if(btn == self.agreementBtn)
    {
        isAgree = !isAgree;
        [self.agreementBtn setBackgroundImage:[UIImage imageNamed:(isAgree?@"cellSelect_fill":@"cellUnSelect_fill")] forState:UIControlStateNormal];
    }
    else if(btn == self.okBtn)
    {
        if(!isAgree)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"请先同意《车主通》协议。" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
            [alert show];
            return;
        }
        
        if (nil != tempField)
        {
            [tempField resignFirstResponder];
        }
        
        NSString *str = nil;
        if(userNameStr == nil || [@"" isEqualToString:userNameStr])
        {
            str = @"用户名不能为空";
        }
        
        if(nil == phoneNumStr || [@"" isEqualToString:phoneNumStr])
        {
            str = @"电话号码不能为空";
        }
        
        if(nil == verificationCodeStr || [@"" isEqualToString:verificationCodeStr])
        {
            str = @"验证码不能为空";
        }
        
        if(nil == passWordTextStr || [@"" isEqualToString:passWordTextStr] || nil == againPasswordTextStr || [@"" isEqualToString:againPasswordTextStr])
        {
            str = @"密码不能为空";
        }
        
        if(![passWordTextStr isEqualToString:againPasswordTextStr])
        {
            str = @"两次密码输入不一致";
        }
        
        if(nil != str)
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:str delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
            [alert show];
            return;
        }
        else
        {
            [self appRegistered];
        }
    }
}

#pragma mark 发送短信
-(void)appgetvalidcode
{
    FVCustomAlertView *hud = [[FVCustomAlertView alloc] init];
    [hud showAlertWithonView:self.view Width:100 height:100 contentView:nil cancelOnTouch:false Duration:-1];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:phoneNumStr forKey:@"mobilenumber"];
    
    NSString *temp = appbase;
    [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].wxBaseServiceURL ServiceName:[temp stringByAppendingString:@"/appgetvalidcode"] params:params httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result)
    {
        NSString *str = nil;
        BOOL issucess = false;
        if(result == nil)
        {
            str = @"发送短信失败，请检查网络是否连接";
        }
        else
        {
            NSDictionary *dic = (NSDictionary *)result;
            if(nil != dic)
            {
                NSString *restate = [dic objectForKey:@"restate"];
                if([@"1" isEqualToString:restate])
                {
                    //成功
                    issucess = true;
                }
                else
                {
                    //失败
                    str = [dic objectForKey:@"redes"];
                }
            }
            else
            {
                str = @"发送短信失败，请检查网络是否连接";
            }
        }
        
        [hud dismiss];
        
        if(issucess)
        {
            //开始计时
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(nsTimerFinish) userInfo:nil repeats:YES];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:str delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles: nil];
            [alert show];
        }
        
    }];
}

#pragma mark 定时结束
-(void)nsTimerFinish
{
    if (count == 1)
    {
        [timer invalidate];
        self.getCodeBtn.userInteractionEnabled = YES;
        [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    else
    {
        count--;
        NSString *title = [NSString stringWithFormat:@"剩余%d秒",count];
        self.getCodeBtn.userInteractionEnabled = NO;
        [self.getCodeBtn setTitle:title forState:UIControlStateNormal];
    }
}

#pragma mark 注册
-(void)appRegistered
{
    FVCustomAlertView *hud = [[FVCustomAlertView alloc] init];
    [hud showAlertWithonView:self.view Width:100 height:100 contentView:nil cancelOnTouch:false Duration:-1];
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:userNameStr forKey:@"userflag"];
    [params setObject:[DESCript encrypt:passWordTextStr encryptOrDecrypt:kCCEncrypt key:[Util getKey]] forKey:@"password"];
    [params setObject:phoneNumStr forKey:@"mobilephone"];
    [params setObject:@"" forKey:@"emails"];
    [params setObject:verificationCodeStr forKey:@"code"];
    [params setObject:@"22" forKey:@"usertype"];
    [params setObject:@"" forKey:@"registtype"];
    [params setObject:@"" forKey:@"companyname"];
    [params setObject:@"" forKey:@"companyno"];
    [params setObject:@"" forKey:@"address"];
    [params setObject:@"" forKey:@"companytype"];
    [params setObject:@"" forKey:@"maplon"];
    [params setObject:@"" forKey:@"maplat"];
    
    NSString *temp = appbase;
    [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].wxBaseServiceURL ServiceName:[temp stringByAppendingString:@"/appregistered"] params:params httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        NSString *str = nil;
        BOOL isSucess = false;
        if(nil == result)
        {
            str = @"请检查网络是否连接";
        }
        else
        {
            NSDictionary *dic = (NSDictionary *)result;
            if(nil != dic)
            {
                NSString *restate = [dic objectForKey:@"restate"];
                if([@"1" isEqualToString:restate])
                {
                    str = @"注册成功";
                    isSucess = true;
                    isRegSucess = true;
                }
                else
                {
                    str = [dic objectForKey:@"redes"];
                }
            }
            else
            {
                str = @"请检查网络是否连接";
            }
        }
        
        [hud dismiss];
        
        FVCustomAlertView *noticeHUD = [[FVCustomAlertView alloc] init];
        UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
        noticeLabel.text = str;
        noticeLabel.textAlignment = NSTextAlignmentCenter;
        noticeLabel.font = [UIFont systemFontOfSize:14];
        noticeLabel.textColor = [UIColor whiteColor];
        [noticeHUD showAlertWithonView:self.view Width:200 height:60 contentView:noticeLabel cancelOnTouch:false Duration:3];
        
        if(isSucess)
        {
            if(nil != self.regViewControllerDelegate)
            {
                [self.regViewControllerDelegate regViewControllerClose:self sucess:true];
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
        
    } ];
}

#pragma mark UITextField代理
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == self.userName)
    {
        userNameStr = textField.text;
    }
    else if(textField == self.phoneNum)
    {
        phoneNumStr = textField.text;
    }
    else if(textField == self.verificationCode)
    {
        verificationCodeStr = textField.text;
    }
    else if(textField == self.passWordText)
    {
        passWordTextStr = textField.text;
    }
    else if(textField == self.againPasswordText)
    {
        againPasswordTextStr = textField.text;
    }
}


-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    tempField = textField;
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
