//
//  FastOperateViewController.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 15/12/18.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "FastOperateViewController.h"

@interface FastOperateViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *FastWebView;

@end

@implementation FastOperateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self requestData];
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

#pragma mark -
#pragma mark - 数据请求
-(void)requestData{
    NSURL *url = [NSURL URLWithString:_resbookimgurl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _FastWebView.delegate = self;
    [_FastWebView setScalesPageToFit:NO];
    _FastWebView.paginationBreakingMode = UIWebPaginationBreakingModePage;
    [self setWebViewStatus];
    [_FastWebView loadRequest:request];

}

-(void)setWebViewStatus
{
    for (UIView *_aView in [_FastWebView subviews]) {
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
