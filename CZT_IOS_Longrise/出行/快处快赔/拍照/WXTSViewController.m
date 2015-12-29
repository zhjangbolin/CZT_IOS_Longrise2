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
    
//    UIImage *okImage = [UIImage imageNamed:@"item_bg-on"];
//    CGFloat top = 100;
//    CGFloat bottom = 100;
//    CGFloat left = 100;
//    CGFloat right = 100;
//    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
//    okImage = [okImage resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
//    [self.okBtn setBackgroundImage:okImage forState:UIControlStateNormal];
    [self.okBtn setBackgroundColor:[UIColor colorWithRed:61/255.0 green:166/255.0 blue:244/255.0 alpha:1]];
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
