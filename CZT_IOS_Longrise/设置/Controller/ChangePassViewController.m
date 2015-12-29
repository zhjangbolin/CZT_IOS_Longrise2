//
//  ChangePassViewController.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/12.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "ChangePassViewController.h"
#import "CZT_IOS_Longrise.pch"
#import "AppDelegate.h"
#import "AFNetWorkService.h"
#import "Globle.h"
#import "DESCript.h"
#import "IQKeyboardManager.h"

@interface ChangePassViewController ()<UIAlertViewDelegate,UITextFieldDelegate>{
    UIAlertView *changeSuccessAlertView;
}

@end

@implementation ChangePassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [AppDelegate storyBoradAutoLay:self.view];
    
//    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
//    manager.enable = NO;
//    manager.enableAutoToolbar = NO;
    
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = BackColor;
    self.title = @"修改密码";

    self.oldPassField.layer.borderWidth   = 0.5;
    self.oldPassField.layer.borderColor   = BackColor.CGColor;
    self.passNewField.layer.borderWidth   = 0.5;
    self.passNewField.layer.borderColor   = BackColor.CGColor;
    self.repeatNewField.layer.borderWidth = 0.5;
    self.repeatNewField.layer.borderColor = BackColor.CGColor;
    self.repeatNewField.returnKeyType = UIReturnKeyDone;
    self.confirmBtn.layer.cornerRadius    = 7;
}
    
- (IBAction)confirmChanged:(id)sender {
    [self.view endEditing:YES];
    if (_oldPassField.text.length > 0 && _passNewField.text.length > 0 && _repeatNewField.text.length > 0) {
        if ([_passNewField.text isEqualToString:_repeatNewField.text]) {
            
           [self requestChangePassword];
        }else{
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"修改密码失败！" message:@"新密码两次输入不相同！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
        
    }else{

        UIAlertView *warnAlertView = [[UIAlertView alloc]initWithTitle:nil message:@"用户信息未填满！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [warnAlertView show];
    }
    
}
    
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - 修改密码请求
-(void)requestChangePassword{
    
    NSDictionary *bigDic = [Globle getInstance].loginInfoDic;
    NSLog(@"bigdic%@",bigDic);
    NSDictionary *userdic = [bigDic objectForKey:@"userinfo"];
    NSString *token = [bigDic objectForKey:@"token"];
    
    NSMutableDictionary *bean = [NSMutableDictionary dictionary];
    [bean setValue:userdic[@"userflag"] forKey:@"userflag"];
    [bean setObject:[DESCript encrypt:_oldPassField.text encryptOrDecrypt:kCCEncrypt key:[Util getKey]] forKey:@"passwordold"];
    [bean setObject:[DESCript encrypt:_passNewField.text encryptOrDecrypt:kCCEncrypt key:[Util getKey]] forKey:@"passwordnew"];
    [bean setValue:token forKey:@"token"];
    
    [[Globle getInstance].service requestWithServiceIP:WXBaseServiceURL ServiceName:[NSString stringWithFormat:@"%@/appusermodifypwd",appbase] params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        if (nil != result) {
            NSDictionary *dic = result;
            if ([dic[@"restate"]isEqualToString:@"1"]) {
                changeSuccessAlertView = [[UIAlertView alloc]initWithTitle:nil message:@"密码修改成功！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [changeSuccessAlertView show];
               // NSLog(@"修改成功!");
            }else if([dic[@"restate"]isEqualToString:@"-5"]){
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"未查到用户信息！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
                NSLog(@"%@",dic[@"redes"]);
            }else if ([dic[@"restate"]isEqualToString:@"-8"]){
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"旧密码输入不正确！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
                NSLog(@"%@",dic[@"redes"]);
            }else if ([dic[@"restate"]isEqualToString:@"-9"]){
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"新密码与旧密码不可相同！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
                NSLog(@"%@",dic[@"redes"]);
            }else{
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"修改密码失败！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alertView show];
                NSLog(@"%@",dic[@"redes"]);
            }
        }
    }];
    
}

//开始编辑输入框的时候，软键盘出现，执行此事件
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //当机型为4s时上移self.view
    if (ScreenHeight == 480) {
        int offset;
        if (textField == _repeatNewField) {
            offset = textField.frame.origin.y + 110 - (self.view.frame.size.height - 216.0);//键盘高度216
        }
        else if (textField == _passNewField){
            self.view.frame =CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
        }
        
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
        if(offset > 0)
            self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if (ScreenHeight == 480) {
        self.view.frame =CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    return YES;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [_repeatNewField resignFirstResponder];
    if (ScreenHeight == 480) {
        self.view.frame =CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    }
}

#pragma mark -
#pragma mark - alertView代理方法
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (changeSuccessAlertView == alertView) {
        [self.view endEditing:YES];
        [self performSelector:@selector(backToLast) withObject:nil afterDelay:0.5];
    }
}

-(void)backToLast{
    [self.navigationController popViewControllerAnimated:YES];
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
