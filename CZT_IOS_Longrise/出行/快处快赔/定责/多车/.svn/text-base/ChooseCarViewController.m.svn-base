//
//  ChooseCarViewController.m
//  CZT_IOS_Longrise
//
//  Created by OSch on 15/12/7.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "ChooseCarViewController.h"
#import "FillInformationController.h"
#import "CZT_IOS_Longrise.pch"
#import "Util.h"
#import <Masonry.h>
#import "ChooseCarViewCell.h"

@interface ChooseCarViewController ()
{
    NSString *carNumber;
    UIView *views;
    UIImageView *checkImage;
}
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSMutableArray *viewData;

@end

@implementation ChooseCarViewController

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)viewData
{
    if (_viewData == nil) {
        _viewData = [NSMutableArray array];
    }
    return _viewData;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //获取数据
    [self setCarData];
    //加载View
    [self setShowView];
    
}

#pragma mark - 加载显示的View
- (void)setShowView
{
    self.backScrollView.contentSize = CGSizeMake(0, 500);
    for (int i = 0; i < self.dataSource.count; i++)
    {
        views = [[UIView alloc]init];
        views.backgroundColor = [UIColor whiteColor];
        views.tag = i + 1;
        views.userInteractionEnabled = YES;
        views.layer.cornerRadius = 2;
        views.layer.masksToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
        [tap addTarget:self action:@selector(TapClick:)];
        [views addGestureRecognizer:tap];
        [self.backScrollView addSubview:views];
        [self.viewData addObject:views];
        [views mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(50);
            make.left.equalTo(self.backScrollView).with.offset(0);
            make.top.mas_equalTo((views.frame.origin.y + views.frame.size.height + 65)* i + 20);
            make.width.mas_equalTo(self.backScrollView.mas_width);
        }];
        
        UILabel *label = [[UILabel alloc]init];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = self.dataSource[i];
        [views addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.mas_equalTo(views.mas_centerX);
            make.centerY.mas_equalTo(views.mas_centerY);
            make.height.mas_equalTo(50);
            make.width.mas_equalTo(200);
        }];
        
        checkImage = [[UIImageView alloc]init];
        checkImage.hidden = YES;
        checkImage.image = [UIImage imageNamed:@"checked"];
        [views addSubview:checkImage];
        [checkImage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(25);
            make.right.equalTo(views).with.offset(-10);
            make.centerY.mas_equalTo(views.mas_centerY);
            
            make.width.mas_equalTo(25);
        }];
    }
    
    UIButton *otherButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    otherButton.backgroundColor = [UIColor whiteColor];
    otherButton.layer.cornerRadius = 2;
    otherButton.layer.masksToBounds = YES;
    [otherButton setTitle:@"其他" forState:UIControlStateNormal];
    [otherButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [otherButton addTarget:self action:@selector(otherChooseClick) forControlEvents:UIControlEventTouchUpInside];
    [self.backScrollView addSubview:otherButton];
    [self.viewData addObject:views];
    [otherButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.left.equalTo(self.backScrollView).with.offset(0);
        make.top.equalTo(views.mas_bottom).with.offset(20);
        make.width.mas_equalTo(self.backScrollView.mas_width);
    }];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    sureButton.backgroundColor = NavColor;
    sureButton.layer.cornerRadius = 2;
    sureButton.layer.masksToBounds = YES;
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(chooseSureButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.backScrollView addSubview:sureButton];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.left.equalTo(self.backScrollView).with.offset(10);
        make.top.equalTo(otherButton.mas_bottom).with.offset(20);
        make.width.mas_equalTo(self.backScrollView.mas_width);
    }];
}
#pragma mark - 点击手势
-(void)TapClick:(UITapGestureRecognizer *)recognizer
{
    UILabel *carlabel = recognizer.view.subviews[0];
    carNumber = carlabel.text;
    NSLog(@"carNumber = %@",carNumber);
    for (UIView *viewstatus in self.viewData)
    {
        viewstatus.tag = 0;
        ((UIView *)viewstatus.subviews[1]).hidden = YES;
    }

    UIView *checkView = recognizer.view;
    checkView.tag = 1;
    
    if (checkView.tag == 1)
    {
        ((UIView *)checkView.subviews[1]).hidden = NO;
     
    }
    else
    {
        ((UIView *)checkView.subviews[1]).hidden = YES;
    }
   
}
- (void)setCarData
{
    for (NSDictionary *str in self.CarDict) {
        [self.dataSource addObject:str[@"carno"]];
    }
     NSLog(@"car = %@",self.dataSource[0]);
}


#pragma mark 确定
-(void)chooseSureButtonClick
{
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"FillInfomation" bundle:nil];
    FillInformationController *filleVC = [storyboard instantiateViewControllerWithIdentifier:@"fillinfomationID"];
    filleVC.hidesBottomBarWhenPushed = YES;
    filleVC.appcaseno = self.appcaseno;
    filleVC.reciveCarNumber = carNumber;
    filleVC.describeData = self.describeData;
    filleVC.describeString = self.describeString;
//    filleVC.reciveCarNumber = dic[@"carno"];
    [self.navigationController pushViewController:filleVC animated:YES];
}

#pragma mark 其他
- (void)otherChooseClick {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"FillInfomation" bundle:nil];
    FillInformationController *filleVC = [storyboard instantiateViewControllerWithIdentifier:@"fillinfomationID"];
    filleVC.hidesBottomBarWhenPushed = YES;
    filleVC.appcaseno = self.appcaseno;
    filleVC.describeData = self.describeData;
    filleVC.describeString = self.describeString;
    [self.navigationController pushViewController:filleVC animated:YES];
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
