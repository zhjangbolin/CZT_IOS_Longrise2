//
//  WXTSViewController.m
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/11/28.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "WXTSViewController.h"
#import "WXTSViewController2.h"

@interface WXTSViewController ()

@end

@implementation WXTSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"温馨提示";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.icon1.layer.cornerRadius = 5;
    self.icon2.layer.cornerRadius = 5;
    self.icon3.layer.cornerRadius = 5;
    
    self.okBtn.layer.cornerRadius = 5;
    [self.okBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)onClick:(UIButton *)btn
{
    WXTSViewController2 *wxtsController2 = [[WXTSViewController2 alloc] init];
    [self.navigationController pushViewController:wxtsController2 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
