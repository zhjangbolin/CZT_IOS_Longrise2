//
//  FVCustomAlertView.m
//  CustomAlertView
//
//  Created by 程三 on 15/7/24.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "FVCustomAlertView.h"

@implementation FVCustomAlertView

-(id)init
{
    self = [super init];
    {
        
    }
    return self;
}

-(void)showAlertWithonView:(UIView *)view
                 Width:(int)width
                 height:(int)height
                 contentView:(UIView *)contentView
                 cancelOnTouch:(BOOL)cancel
                 Duration:(int)duration
{
    
    //获取设备的宽和高
    CGRect windowRect = [[UIScreen mainScreen] bounds];
    self.frame = windowRect;
    
    if(contentView == nil)
    {
        //创建对话框
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(windowRect.size.width/2 - width/2,windowRect.size.height/2 - 100/2,width,height)];
        alertView.backgroundColor = [UIColor blackColor];
        alertView.layer.cornerRadius = 10;
        alertView.alpha = 0.7;
        [self addSubview:alertView];
        
        
        UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activityView.frame = CGRectMake((width - 50)/2, (height - 50)/2, 50, 50);
        [activityView startAnimating];
        
        [alertView addSubview:activityView];
    }
    else
    {
        //创建对话框
        UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(windowRect.size.width/2 - width/2,windowRect.size.height/2 - 100/2,width,height)];
        alertView.backgroundColor = [UIColor blackColor];
        alertView.layer.cornerRadius = 10;
        alertView.alpha = 0.8;
        [self addSubview:alertView];
        
        [alertView addSubview:contentView];
    }
    
    

    if(cancel)
    {
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:[FVCustomAlertView class] action:@selector(hideAlertByTap:)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:tapGesture];
    }
    
    
//    UIViewController *viewController = [[[UIApplication sharedApplication] windows][0] rootViewController];
//    [viewController.view addSubview:self];
    
    [view.window addSubview:self];
    
    if(duration > 0)
    {
        //定时器
        [NSTimer scheduledTimerWithTimeInterval:duration target:self selector:@selector(testTimer:) userInfo:self repeats:NO];
    }
   
    
}

-(void)hideAlertByTap:(UITapGestureRecognizer *)gesture
{
    //[gesture.view  removeFromSuperview];
    [self dismiss];
}

-(void)testTimer:(NSTimer *)timer
{
//    UIView *resultView = timer.userInfo;
//    if(resultView != nil)
//    {
//        [resultView  removeFromSuperview];
//    }
    
    [self dismiss];
}

-(void)dismiss
{
    if([self superview])
    {
        [self removeFromSuperview];
    }
    
    if(nil != self.customAlertViewDelegate)
    {
        [self.customAlertViewDelegate customAlertViewDismiss:self];
    }
}

@end
