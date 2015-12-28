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
    
    //设置按钮监听
    [self.moreCarCaseBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.oneCaseBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark 按钮点击回调方法
-(void)onClick:(UIButton *)btn
{
    if(btn == self.moreCarCaseBtn)
    {
        PhoneViewController *phoneController = [TakePhoneFactory createPhoneViewController:2];
        [self.navigationController pushViewController:phoneController animated:YES];
    }
    else if(btn == self.oneCaseBtn)
    {
        PhoneViewController *phoneController = [TakePhoneFactory createPhoneViewController:1];
        [self.navigationController pushViewController:phoneController animated:YES];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
