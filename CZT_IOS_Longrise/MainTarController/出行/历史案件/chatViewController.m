//
//  chatViewController.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 15/12/18.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "chatViewController.h"
#import "FVCustomAlertView.h"

@interface chatViewController ()<UIWebViewDelegate>{
    FVCustomAlertView *alertView;
}
@property (weak, nonatomic) IBOutlet UIWebView *chatWebView;

@end

@implementation chatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"交警沟通信息";
    [self requestData];
    [self beginAnimation];
    // Do any additional setup after loading the view from its nib.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
        self.hidesBottomBarWhenPushed = YES;
        //self.isShowController = true;
    }
    return self;
}

#pragma mark - 进场动画
-(void)beginAnimation{
    alertView = [[FVCustomAlertView alloc] init];
    [alertView showAlertWithonView:self.view Width:100 height:100 contentView:nil cancelOnTouch:false Duration:-1];
    [self.view addSubview:alertView];
}

#pragma mark -
#pragma mark - 数据请求
-(void)requestData{
    
    NSURL *url = [NSURL URLWithString:self.chatUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _chatWebView.delegate = self;
    [_chatWebView setScalesPageToFit:NO];
    _chatWebView.paginationBreakingMode = UIWebPaginationBreakingModePage;
    [self setWebViewStatus];
    [_chatWebView loadRequest:request];
}

#pragma mark -
#pragma mark - 网页代理方法
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [alertView dismiss];
}

-(void)setWebViewStatus
{
    for (UIView *_aView in [_chatWebView subviews]) {
        if ([_aView isKindOfClass:[UIScrollView class]]) {
            //右侧
            [(UIScrollView *)_aView setShowsHorizontalScrollIndicator:NO];
            //下侧
            [(UIScrollView *)_aView setShowsVerticalScrollIndicator:NO];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
