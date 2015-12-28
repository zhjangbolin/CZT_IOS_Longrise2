//
//  LoginViewController.h
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/11/30.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "PublicViewController.h"
#import "Util.h"
#import "SHA1Encrypt.h"
#import "DESCript.h"
#import "FVCustomAlertView.h"
#import "CZT_IOS_Longrise.pch"
#import "RegViewController.h"

@protocol LoginControllerClose<NSObject>
@required
-(void)LoginControllerClose:(UIViewController *)viewController success:(BOOL)b;
@end

@interface LoginViewController : PublicViewController<UITextFieldDelegate>
{
    NSString *userName;
    NSString *passWord;
    FVCustomAlertView *alertView;
    
}

@property(nonatomic,assign)BOOL isShowController;
@property(nonatomic,copy)NSString *controllerName;

@property (nonatomic, assign)   id <LoginControllerClose> loginControllerClose;

@property (weak, nonatomic) IBOutlet UITextField *userNameFild;
@property (weak, nonatomic) IBOutlet UITextField *passFild;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *regBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetPassBtn;

@end
