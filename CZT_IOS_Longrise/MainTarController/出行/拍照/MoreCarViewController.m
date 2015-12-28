//
//  MoreCarViewController.m
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/11/28.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "MoreCarViewController.h"
#import "UIViewExt.h"
#import "Util.h"

@interface MoreCarViewController ()

@end

@implementation MoreCarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self _initView];
}

#pragma mark 初始化UI
-(void)_initView
{
    NSLog(@"self.phoneView1.width = %f",self.phoneView1.width);
    NSLog(@"getUIScreenWidth = %f",[Util getUIScreenWidth]);
    int cellWidth = ([Util getUIScreenWidth] - 10)/2;
    int cellHeight = self.phoneView1.height;
    
    {
        CGRect frame = CGRectMake(0, 0, cellWidth, cellHeight);
        self.phoneCellView1 =[self CreateCell:@"1111" image:[UIImage imageNamed:@"nav01"] frame:&frame];
        [self.phoneView1 addSubview:self.phoneCellView1];
    }
    
    {
        CGRect frame = CGRectMake(cellWidth + 10, 0, cellWidth, cellHeight);
        self.phoneCellView2 =[self CreateCell:@"1111" image:[UIImage imageNamed:@"nav01"] frame:&frame];
        [self.phoneView1 addSubview:self.phoneCellView2];
    }
    
    {
        CGRect frame = CGRectMake(0, 0, cellWidth, cellHeight);
        self.phoneCellView3 =[self CreateCell:@"1111" image:[UIImage imageNamed:@"nav01"] frame:&frame];
    }
    
    {
        CGRect frame = CGRectMake(cellWidth + 10, 0, cellWidth, cellHeight);
        self.phoneCellView4 =[self CreateCell:@"1111" image:[UIImage imageNamed:@"nav01"] frame:&frame];
    }
    
    {
        CGRect frame = CGRectMake(0, 0, cellWidth, cellHeight);
        self.phoneCellView5 =[self CreateCell:@"1111" image:[UIImage imageNamed:@"nav01"] frame:&frame];
    }
    
    {
        CGRect frame = CGRectMake(cellWidth + 10, 0, cellWidth, cellHeight);
        self.phoneCellView6 =[self CreateCell:@"1111" image:[UIImage imageNamed:@"nav01"] frame:&frame];
    }
    
    
    self.finishBtn.layer.cornerRadius = 5;
}

#pragma mark 初始化PhoneCellView
-(PhoneCellView *)CreateCell:(NSString *)title image:(UIImage *)image frame:(CGRect *)frame
{
    PhoneCellView *cell = [[PhoneCellView alloc] initWithFrame:*frame];
    [cell setTitle:title];
    [cell setImage:image];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
