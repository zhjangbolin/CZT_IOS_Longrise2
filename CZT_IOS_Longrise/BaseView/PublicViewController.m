//
//  PublicViewController.m
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/11/30.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "PublicViewController.h"
#import "UIViewExt.h"

@interface PublicViewController ()

@end

@implementation PublicViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //设置navigationBar的背景颜色
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:61/255.0 green:166/255.0 blue:244/255.0 alpha:1];
    
    NSArray *array = self.navigationController.viewControllers;
    if(array.count > 1)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 45, 30);
        [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
        
        //图标
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"public_back"]];
        imageView.frame = CGRectMake(10, 0, 30, 30);
        [button addSubview:imageView];
        
        // 调整 leftBarButtonItem 在 iOS7 下面的位置
        
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        if(([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?20:0))
            
        {
            UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                           target:nil action:nil];
            negativeSpacer.width = -20;//这个数值可以根据情况自由变化
            self.navigationItem.leftBarButtonItems = @[negativeSpacer, backItem];
        }
        else
        {
            self.navigationItem.leftBarButtonItem = backItem;
        }
    }
}

#pragma mark 设置标题
-(void)setTitle:(NSString *)title
{
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.text = title;
    [titleLabel sizeToFit];
    self.navigationItem.titleView = titleLabel;
}

#pragma mark 设置颜色
-(void)setTitleColor:(UIColor *)color
{
    if(nil != titleLabel)
    {
        titleLabel.textColor = color;
    }
}

#pragma mark 设置字体大小
-(void)setTitleSize:(UIFont *)font
{
    if(nil != titleLabel)
    {
        titleLabel.font = font;
    }
}

#pragma mark 返回
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
