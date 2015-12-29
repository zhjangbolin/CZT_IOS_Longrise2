//
//  LoginViewController.m
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/11/30.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "LoginViewController.h"
#import "Globle.h"
#import "NSString+NSStringMD5.h"
#import "SGCLViewController.h"
#import "ForgotPasswordViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
        self.hidesBottomBarWhenPushed = YES;
        //self.isShowController = true;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"登 录";
    [self _initView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //判断用户名和密码是否为空，不为空直接登录
    NSString *u = [UserDefaultsUtil getDataForKey:@"userName"];
    NSString *p = [UserDefaultsUtil getDataForKey:@"passWord"];
    if(nil == u || p == nil || [@"" isEqualToString:u] || [@"" isEqualToString:p])
    {
        return;
    }
    
    [self.userNameFild setText:u];
    [self.passFild setText:p];
    userName = u;
    passWord = p;
    
    [self startLoadData];
}

#pragma mark 初始化UI
-(void)_initView
{
    CGFloat left = 10;
    self.userNameFild.delegate = self;
    [Util setTextFieldLeftPadding:self.userNameFild forWidth:left];
    self.passFild.delegate = self;
    [Util setTextFieldLeftPadding:self.passFild forWidth:left];
    
    self.loginBtn.layer.cornerRadius = 5;
    [self.loginBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    //注册
    [self.regBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    //忘记密码
    [self.forgetPassBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 点击回调函数
-(void)onClick:(UIButton *)btn
{
    //[self.view endEditing:NO];
    //隐藏键盘
    [self.passFild resignFirstResponder];
    [self.userNameFild resignFirstResponder];
    
    if(btn == self.loginBtn)
    {
        if(btn == self.loginBtn)
        {
            if(nil == userName || [@"" isEqualToString:userName])
            {
                [self showNoticeMsg:@"用户名为空"];
                return;
            }
            
            if(nil == passWord || [@"" isEqualToString:passWord])
            {
                [self showNoticeMsg:@"密码为空"];
                return;
            }
        }
        
        [self startLoadData];
    }
    else if(btn == self.regBtn)
    {
        [self regUser];
    }
    else if(btn == self.forgetPassBtn)
    {
    
    }
}

#pragma mark 开始加载数据
-(void)startLoadData
{
    alertView = [[FVCustomAlertView alloc] init];
    [alertView showAlertWithonView:self.view Width:100 height:100 contentView:nil cancelOnTouch:false Duration:-1];
    
    NSMutableDictionary *bean = [[NSMutableDictionary alloc] init];
    NSString *userflag = userName;
    NSString *password = [DESCript encrypt:passWord encryptOrDecrypt:kCCEncrypt key:[Util getKey]];
    NSLog(@"密码：%@",password);
    [bean setValue:userflag forKey:@"userflag"];
    [bean setValue:password forKey:@"password"];
    
    NSString *tempStr = appbase;
    [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].wxBaseServiceURL ServiceName:[tempStr stringByAppendingString:@"/applogin"] params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        [self loadFinish:result];
    } ];
    
}

#pragma mark 数据加载完成
-(void)loadFinish:(id)result
{
    NSString *string = nil;
    if(nil == result)
    {
        string = @"登陆失败,请检查网络。";
    }
    else
    {
        NSDictionary *dic = result;
        //判断是否登陆成功
        NSString *restate = [dic objectForKey:@"restate"];
        if([@"1" isEqualToString:restate])
        {
            //登陆成功
            [Globle getInstance].loginInfoDic = [dic objectForKey:@"data"];
            if(nil != [Globle getInstance].loginInfoDic)
            {
                [Globle getInstance].token = [[Globle getInstance].loginInfoDic objectForKey:@"token"];
            }
            //将登陆信息存到本地
            [UserDefaultsUtil saveNSUserDefaultsForObject:[dic objectForKey:@"data"] forKey:LoginFileName];
            
            //用户名和密码保存到本地
            [UserDefaultsUtil saveNSUserDefaultsForObject:userName forKey:@"userName"];
            [UserDefaultsUtil saveNSUserDefaultsForObject:passWord forKey:@"passWord"];
            
            if(self.isShowController)
            {
                if(nil != self.controllerName)
                {
                    Class someClass = NSClassFromString(self.controllerName);
                    id obj = [[someClass alloc] init];
                    BaseViewController *baseController = (BaseViewController *)obj;
                    //SGCLViewController *sgclController = [[SGCLViewController alloc] init];
                    [self.navigationController pushViewController:baseController animated:YES];
                }
            }
            else
            {
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
            if(nil != alertView)
            {
                [alertView dismiss];
            }
            
            if(nil != self.loginControllerClose)
            {
                [self.loginControllerClose LoginControllerClose:self success:YES];
            }
            return;
        }
        else
        {
            //登陆失败
            string = (NSString *)[dic objectForKey:@"redes"];
        }
    }
    
    if(nil != alertView)
    {
        [alertView dismiss];
    }
    
    UIAlertView *tempAlert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:string delegate:self cancelButtonTitle:@"确 定" otherButtonTitles: nil];
    [tempAlert show];
}

#pragma mark 提示
-(void)showNoticeMsg:(NSString *)msg
{
    FVCustomAlertView *noticeHUD = [[FVCustomAlertView alloc] init];
    UILabel *noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 60)];
    noticeLabel.text = msg;
    noticeLabel.textAlignment = NSTextAlignmentCenter;
    noticeLabel.font = [UIFont systemFontOfSize:14];
    noticeLabel.textColor = [UIColor whiteColor];
    [noticeHUD showAlertWithonView:self.view Width:200 height:60 contentView:noticeLabel cancelOnTouch:false Duration:3];

}

#pragma mark UITextView 回调函数
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == self.userNameFild)
    {
        userName = textField.text;
        NSLog(@"输入用户名结束%@",userName);
    }
    else if(textField == self.passFild)
    {
        passWord = textField.text;
        NSLog(@"输入密码结束%@",passWord);
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //    if(textField == self.userNameFild)
    //    {
    //        userName = textField.text;
    //        NSLog(@"shouldChangeCharactersInRange输入用户名结束%@",userName);
    //    }
    //    else if(textField == self.passFild)
    //    {
    //        passWord = textField.text;
    //        NSLog(@"shouldChangeCharactersInRange输入密码结束%@",passWord);
    //    }
    
    return YES;
}

#pragma mark 注册
-(void)regUser
{
    RegViewController *regController = [[RegViewController alloc] init];
    [self.navigationController pushViewController:regController animated:YES];
}

#pragma mark -
#pragma mark - 忘记密码点击事件
- (IBAction)forgotPasswordBtnClicked:(id)sender {
    ForgotPasswordViewController *forgotController = [[ForgotPasswordViewController alloc]init];
    [self.navigationController pushViewController:forgotController animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
