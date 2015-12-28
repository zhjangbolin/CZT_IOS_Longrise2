//
//  BreakRulesViewController.m
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/12/7.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "BreakRulesViewController.h"

@interface BreakRulesViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation BreakRulesViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createWebView];
    // Do any additional setup after loading the view from its nib.
}

-(void)createWebView{

    NSURL *url = [NSURL URLWithString:@"http://www.bjjtgl.gov.cn/weifachaxun/wfcxnew.htm"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _webView.delegate = self;
    [_webView setScalesPageToFit:NO];
//    _webView.scrollView.contentSize = CGSizeMake(450, 667);
    _webView.paginationBreakingMode = UIWebPaginationBreakingModePage;
//    _webView.scrollView.pagingEnabled = NO;
//    [self setWebViewStatus];
   // [_webView sizeToFit];
    [_webView loadRequest:request];
}

-(void)setWebViewStatus
{
    for (UIView *_aView in [_webView subviews]) {
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

//-(void)viewWillDisappear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden = NO;
//}
//
//-(void)viewWillAppear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden = YES;
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
