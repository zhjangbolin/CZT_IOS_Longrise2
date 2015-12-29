//
//  SecondViewController.m
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/12/29.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.guideFinishBtn.layer.cornerRadius = 10;
    self.guideFinishBtn.layer.masksToBounds = YES;
    self.guideFinishBtn.layer.borderWidth = 1;
    self.guideFinishBtn.layer.borderColor = [UIColor colorWithRed:51/255.0 green:151/255.0 blue:241/255.0 alpha:1].CGColor;
    [self.guideFinishBtn addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark 点击回调
-(void)onClick:(UIButton *)btn
{
    if(self.guideFinishBtn == btn)
    {
        UIStoryboard *loginStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        self.view.window.rootViewController=[loginStoryboard instantiateInitialViewController];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
