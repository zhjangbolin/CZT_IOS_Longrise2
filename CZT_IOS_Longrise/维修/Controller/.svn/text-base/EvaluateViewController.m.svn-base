//
//  EvaluateViewController.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/12.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "EvaluateViewController.h"
#import "AppDelegate.h"

@interface EvaluateViewController ()<UITextViewDelegate>
{
    HRDetailHeaderView *header;
}
@end

@implementation EvaluateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [AppDelegate storyBoradAutoLay:self.view];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"评价";
    
    self.submitBtn.layer.cornerRadius = 5;
    header = [[NSBundle mainBundle] loadNibNamed:@"HRDetailHeaderView" owner:nil options:nil][0];
    header.frame = self.headerView.bounds;
    
    if (nil !=  _model ) {
        [header setUIWithInfo:self.model];
    }
    
    [self.headerView addSubview:header];
    
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
