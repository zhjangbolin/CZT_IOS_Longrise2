//
//  ARAViewController.m
//  CZT_IOS_Longrise
//
//  Created by OSch on 15/12/5.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "ARAViewController.h"
#import <Masonry.h>
#import "CZT_IOS_Longrise.pch"
#import "FVCustomAlertView.h"
@interface ARAViewController ()<UIWebViewDelegate>
{
    FVCustomAlertView *fvAlert;
}
@end

@implementation ARAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"事故责任协议书";
    
    [self setWebViewStatus];
    
    
    
    fvAlert = [[FVCustomAlertView alloc]init];
    [fvAlert showAlertWithonView:self.view Width:100 height:100 contentView:nil cancelOnTouch:false Duration:-1];
    
   [self setPromptBackViewStatus];
    
}
-(void)setPromptBackViewStatus
{
    self.promptImageView.userInteractionEnabled = YES;
    self.responsWebView.backgroundColor = [UIColor clearColor];
    self.responsWebView.scalesPageToFit =YES;
    self.responsWebView.delegate =self;
    NSURL *url =[[NSURL alloc] initWithString:self.ARVWebString];
    NSURLRequest *request =  [[NSURLRequest alloc] initWithURL:url];
    [self.responsWebView loadRequest:request];
    [fvAlert dismiss];
}

-(void)setWebViewStatus
{
    for (UIView *_aView in [self.responsWebView subviews]) {
        if ([_aView isKindOfClass:[UIScrollView class]]) {
            //右侧
            [(UIScrollView *)_aView setShowsHorizontalScrollIndicator:NO];
            //下侧
            [(UIScrollView *)_aView setShowsVerticalScrollIndicator:NO];
        }
    }
}
//点击确定显示提示图片 确认是否确定
- (IBAction)SureResponsBtn:(id)sender {
    
    self.noticeBackView.hidden = NO;
    self.promptImageView.hidden = NO;
    
    //取证完成通知
    NSString *name = NotificationNameForOneStepFinish;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"2" forKey:@"dealCaseStep"];
    [center postNotificationName:name object:nil userInfo:dic];
    
}

- (IBAction)sureButton:(id)sender {
    
  
    NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
    [self.navigationController popToViewController:[navigationArray objectAtIndex:1] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}


@end
