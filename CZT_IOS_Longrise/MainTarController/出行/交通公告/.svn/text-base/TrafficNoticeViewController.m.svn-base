//
//  TrafficNoticeViewController.m
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/12/7.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "TrafficNoticeViewController.h"

@interface TrafficNoticeViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation TrafficNoticeViewController

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
//    UIWebView *webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    NSURL *url = [NSURL URLWithString:@"http://192.168.3.229:86/KCKP/bjkckp_webmap/bjkckp_trafficnotice"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
    _webView.delegate = self;
    [_webView setScalesPageToFit:YES];
    _webView.paginationBreakingMode = UIWebPaginationBreakingModePage;
    [_webView sizeToFit];
    [self setWebViewStatus];
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

-(void)viewWillDisappear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden = NO;
}

-(void)viewWillAppear:(BOOL)animated{
//    self.tabBarController.tabBar.hidden = YES;
}

//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    //获取页面高度（像素）
//    NSString * clientheight_str = [webView stringByEvaluatingJavaScriptFromString: @"document.body.offsetHeight"];
//    float clientheight = [clientheight_str floatValue];
//    //设置到WebView上
//    webView.frame = CGRectMake(0, 0, self.view.frame.size.width, clientheight);
//    //获取WebView最佳尺寸（点）
//    CGSize frame = [webView sizeThatFits:webView.frame.size];
//    //获取内容实际高度（像素）
//    NSString * height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.getElementById('webview_content_wrapper').offsetHeight + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-top'))  + parseInt(window.getComputedStyle(document.getElementsByTagName('body')[0]).getPropertyValue('margin-bottom'))"];
//    float height = [height_str floatValue];
//    //内容实际高度（像素）* 点和像素的比
//    height = height * frame.height / clientheight;
//    //再次设置WebView高度（点）
//    webView.frame = CGRectMake(0, 0, self.view.frame.size.width, height);
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
