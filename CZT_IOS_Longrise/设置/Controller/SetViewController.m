//
//  SetViewController.m
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/11/27.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "SetViewController.h"
#import "CZT_IOS_Longrise.pch"
#import "SGCLViewController.h"
#import "SetHeaderView.h"
#import "CarManageViewController.h"
#import "ChangePassViewController.h"
#import "InfoViewController.h"
#import "InfoSectionTwoCell.h"
#import "UIImageView+WebCache.h"
#import "LoginViewController.h"
#import "UserDefaultsUtil.h"


@interface SetViewController ()
<UIAlertViewDelegate,LoginControllerClose>
{
    SetHeaderView *header;
    NSArray *imgAry;
    UIAlertView *exitAlertView;
}
@end

@implementation SetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    imgAry = @[@"icon14",@"icon15",@"icon16",@"iconExit"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;

    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"backg"]
                                                 forBarPosition:UIBarPositionAny
                                                     barMetrics:UIBarMetricsDefault];
    //隐藏导航栏底部黑条
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
//    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 30)];
//    lab.text = @"我的";
//    lab.textColor = [UIColor whiteColor];
    
//    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithCustomView:lab];
//    self.navigationItem.leftBarButtonItem = barBtn;
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    backView.backgroundColor = BackColor;
    [self.view addSubview:backView];
    
    header  = [[SetHeaderView alloc]initWithFrame:backView.bounds];
    header.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backg"]];
    [backView addSubview:header];
    
    self.dataSource = @[@"车辆管理",@"修改密码",@"系统设置",@"退出登录"];
    self.hometabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 100, ScreenWidth, ScreenHeight-164) style:UITableViewStylePlain];
    self.hometabView.backgroundColor = BackColor;
    self.hometabView.delegate = self;
    self.hometabView.dataSource = self;
    self.hometabView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:self.hometabView];
    
    [self.hometabView registerNib:[UINib nibWithNibName:@"InfoSectionTwoCell" bundle:nil] forCellReuseIdentifier:@"InfoSectionTwoCell"];
    
    [AppDelegate storyBoradAutoLay:self.view];
    
    if (nil != [Globle getInstance].loginInfoDic) {
        
        [self setHeaderView];
    }
    else{
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"本功能需要登录才能使用，请您登录" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self setHeaderView];
    //隐藏导航条
    self.navigationController.navigationBarHidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

-(void)setHeaderView{

    NSDictionary *bigDic = [Globle getInstance].loginInfoDic;
//    NSLog(@"bigdic%@",bigDic);
    if (bigDic == nil) {
        [header.icon setImage:[UIImage imageNamed:@"icon07"]];
        header.phoneNum.hidden = YES;
        header.userName.hidden = YES;
        header.cellPhone.hidden = YES;
        header.notLoginBtn.hidden = NO;
        [header.notLoginBtn addTarget:self action:@selector(loginBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        return;
    }
    header.notLoginBtn.hidden = YES;
    header.phoneNum.hidden = NO;
    header.userName.hidden = NO;
    header.cellPhone.hidden = NO;
    
    NSDictionary *userdic = [bigDic objectForKey:@"userinfo"];
    [header.icon sd_setImageWithURL:[NSURL URLWithString:[userdic objectForKey:@"photo"]]placeholderImage:[UIImage imageNamed:@"icon07"]];
    header.userName.text = [userdic objectForKey:@"userflag"];
    NSMutableString *phoneNum = [NSMutableString stringWithString:[userdic objectForKey:@"mobilephone"]];
    [phoneNum replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    header.phoneNum.text = phoneNum;

}

#pragma mark -
#pragma mark - 未登陆button点击事件
-(void)loginBtnClicked:(UIButton *)sender{
    [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
}


#pragma mark - alertView Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView == exitAlertView) {

        if (buttonIndex == 0) {
            
            NSLog(@"取消退出登录");
            
        }else{
            
            [Globle getInstance].loginInfoDic = nil;
            [Globle getInstance].token = nil;
            [UserDefaultsUtil removeAllUserDefaults]; //删除所有本地用户信息
            
            [header.icon setImage:[UIImage imageNamed:@"icon07"]];
            header.phoneNum.text = nil;
            header.userName.text = @"未登陆";
            //创建通知
            NSDictionary *dict = [[NSDictionary alloc]initWithObjectsAndKeys:@"1",@"restate",nil];
            NSNotification *notification = [NSNotification notificationWithName:NotificationNameForExit object:nil userInfo:dict];
            //发送通知
            [[NSNotificationCenter defaultCenter]postNotification:notification];
            [self.navigationController pushViewController:[[LoginViewController alloc]init] animated:YES];
            NSLog(@"退出登录!");
            
        }
        
    }else{
    
        if (buttonIndex == 0) {
            LoginViewController *loginVC = [LoginViewController new];
            loginVC.isShowController = false;
            loginVC.loginControllerClose = self;
            [self.navigationController pushViewController:loginVC animated:YES];
        }
    }
}

#pragma mark - 登陆页代理方法
-(void)LoginControllerClose:(UIViewController *)viewController success:(BOOL)b{
    
    if (b) {
        
        [self setHeaderView];
    }
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    InfoSectionTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfoSectionTwoCell"];
    
    cell.icon.image = [UIImage imageNamed:imgAry[indexPath.row]];
    cell.titleLab.text = self.dataSource[indexPath.row];
    cell.rightLab.hidden = YES;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

//补全分割线
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell  respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)])
    {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        
        if ([Globle getInstance].loginInfoDic == nil) {
            [self didNotLoginWarn];
            return;
        }
        CarManageViewController *vc = [CarManageViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row == 1) {
        
        if ([Globle getInstance].loginInfoDic == nil) {
            [self didNotLoginWarn];
            return;
        }
        ChangePassViewController *vc = [ChangePassViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if(indexPath.row == 2){
        
        if ([Globle getInstance].loginInfoDic == nil) {
            [self didNotLoginWarn];
            return;
        }
        InfoViewController *vc = [InfoViewController new];
        vc.hidesBottomBarWhenPushed = YES;
        vc.name = header.userName.text;
        vc.phoneNum = header.phoneNum.text;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        
        if ([Globle getInstance].loginInfoDic == nil) {
            [self didNotLoginWarn];
            return;
        }
        exitAlertView = [[UIAlertView alloc]initWithTitle:nil message:@"退出登录？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定退出", nil];
        [exitAlertView show];
        
    }
    
   
}

//没有登陆时的提醒
-(void)didNotLoginWarn{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"您当前还没有登陆！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
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
