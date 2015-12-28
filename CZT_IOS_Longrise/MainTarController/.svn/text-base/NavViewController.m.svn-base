//
//  NavViewController.m
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/11/27.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "NavViewController.h"
#import "CZT_IOS_Longrise.pch"
@interface NavViewController ()

@end

@implementation NavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.swipeAction = true;
    
    //导航栏文字颜色变为白色
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    //去掉系统自带返回按钮的文字，只保留箭头
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)  forBarMetrics:UIBarMetricsDefault];
    
    //改变返回按钮的颜色为白色
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
    //设置原点坐标从标题栏下面开始
    self.navigationBar.translucent = NO;
    
    //手势对象，一个对象只能监听一个方向的手势
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    //设置监听向右滑的手势
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    //给View添加手势监听
    [self.view addGestureRecognizer:swipeGesture];
}

-(void)swipeAction:(UISwipeGestureRecognizer *)gesture
{
    if(self.swipeAction)
    {
        //判断控制器的数量大于1个时就可以响应手势
        if(self.viewControllers.count > 1)
        {
            //判断是不是右滑手势
            if(gesture.direction == UISwipeGestureRecognizerDirectionRight)
            {
                //删除最上面的控制器
                [self popViewControllerAnimated:YES];
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
