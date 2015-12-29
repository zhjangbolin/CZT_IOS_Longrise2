//
//  WXTSViewController2.m
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/11/28.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "WXTSViewController2.h"
#import "PZQZViewController.h"

@interface WXTSViewController2 ()

@end

@implementation WXTSViewController2

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"温馨提示";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.btn1.layer.cornerRadius = 5;
    self.btn1.layer.borderColor = [UIColor grayColor].CGColor;
    self.btn1.layer.borderWidth = 0.5;
    self.btn1.layer.masksToBounds = YES;
    
    self.btn2.layer.cornerRadius = 5;
    self.btn2.layer.borderColor = [UIColor grayColor].CGColor;
    self.btn2.layer.borderWidth = 0.5;
    self.btn2.layer.masksToBounds = YES;
    
    self.btn3.layer.cornerRadius = 5;
    self.btn3.layer.borderColor = [UIColor grayColor].CGColor;
    self.btn3.layer.borderWidth = 0.5;
    self.btn3.layer.masksToBounds = YES;
    
    self.okBtn.layer.cornerRadius = 5;
    [self.okBtn setBackgroundColor:[UIColor colorWithRed:61/255.0 green:166/255.0 blue:244/255.0 alpha:1]];
    self.repCaseBtn.layer.cornerRadius = 5;
    [self.repCaseBtn setBackgroundColor:[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1]];

    
    //设置监听
    [self.okBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.repCaseBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 按钮点击回调方法
-(void)onClick:(UIButton *)btn
{
    if(btn == self.okBtn)
    {
        PZQZViewController *pzqzController = [[PZQZViewController alloc] init];
        [self.navigationController pushViewController:pzqzController animated:YES];
    }
    else if(btn == self.repCaseBtn)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://112"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
