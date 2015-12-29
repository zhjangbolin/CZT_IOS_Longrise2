//
//  VerifyInfoViewController.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/14.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "VerifyInfoViewController.h"
#import "VerSectionOneCell.h"
#import "CZT_IOS_Longrise.pch"
#import "AFNetWorkService.h"
#import "Globle.h"
#import "FVCustomAlertView.h"
#import "IQKeyboardManager.h"
@interface VerifyInfoViewController ()
<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *table;
    NSArray *sectionTitle;
    NSArray *cellTitle;
    NSMutableArray *dataList;
    FVCustomAlertView *alertView;
    NSString *companyName;
    
}
@end

@implementation VerifyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
    manager.enableAutoToolbar = NO;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"验证信息";
    [self requestCarApprove];
    
    sectionTitle = @[@"1、该车在湖北省武汉市最近一次维修企业是"];
    [self getCurrentLocation];
    cellTitle = @[@"A、",@"B、",@"C、",@"D、"];
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    table.delegate   = self;
    table.dataSource = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.showsVerticalScrollIndicator = NO;
    [self addTableFooterView];
    [self.view addSubview:table];
    
    [table registerNib:[UINib nibWithNibName:@"VerSectionOneCell" bundle:nil] forCellReuseIdentifier:@"section0"];
    
}

-(void)viewWillAppear:(BOOL)animated{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = NO;
    manager.enableAutoToolbar = NO;
}

-(void)viewDidDisappear:(BOOL)animated{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.enableAutoToolbar = YES;
}



-(void)addTableFooterView{

    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    backView.backgroundColor = BackColor;

    table.tableFooterView = backView;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 15, ScreenWidth-20, 50);
    btn.backgroundColor = RGB(17, 137, 232);
    btn.layer.cornerRadius = 5;
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(confirmSelect) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:btn];
}

#pragma mark -
#pragma mark - 请求验证车辆信息数据
-(void)requestCarApprove{
    
    alertView = [[FVCustomAlertView alloc] init];
    [alertView showAlertWithonView:self.view Width:100 height:100 contentView:nil cancelOnTouch:false Duration:-1];
    [self.view addSubview:alertView];
    
    dataList = [NSMutableArray array];
    companyName = nil;
    
    NSDictionary *bigDic = [Globle getInstance].loginInfoDic;
    NSDictionary *userDic = [bigDic objectForKey:@"userinfo"];
    NSString *token = [bigDic objectForKey:@"token"];
   // NSString *str = @"WDDFH3DB0AJ541602";
    
    NSMutableDictionary *bean = [NSMutableDictionary dictionary];
    [bean setValue:userDic[@"userflag"] forKey:@"userflag"];
    [bean setValue:token forKey:@"token"];
    [bean setValue:@"420111111111111111" forKey:@"areaid"];
    [bean setValue:_carNumber forKey:@"carno"];
    [bean setValue:_VINCode forKey:@"carvin"];
  //  [bean setValue:_engineNumber forKey:@"enginenumber"];
    [bean setValue:_engineNumber forKey:@"enginenumber"];
    
    [[Globle getInstance].service requestWithServiceIP:WXServiceURL ServiceName:[NSString stringWithFormat:@"%@/appcarapprove",businessapp] params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        if (nil != result) {
            NSDictionary *bigDic = result;
            if ([bigDic[@"restate"]isEqualToString:@"1"]) {
                NSArray *array = bigDic[@"data"];
            
                for (NSDictionary *dic in array) {
//                    [dataList addObject:dic[@"companyname"]];
                    NSString *companyname = dic[@"companyname"];
                    NSString *address = dic[@"address"];
                    NSString *totalString = [NSString stringWithFormat:@"%@(%@)",companyname,address];
              //      NSLog(@"%@",totalString);
                    [dataList addObject:totalString];
                }
                [table reloadData];
                [alertView dismiss];
            }else{
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"车辆信息验证失败！" message:@"没有查询到车辆维修记录！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                [alertView dismiss];
            }
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"车辆信息验证失败！" message:@"没有查询到车辆相关数据信息！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            [alertView dismiss];
        }
        
    }];
}

#pragma mark - 
#pragma mark - 获取当前位置
-(void)getCurrentLocation{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    //经纬度
    [params setObject:[NSString stringWithFormat:@"%lf",[Globle getInstance].imagelon] forKey:@"maplon"];
    [params setObject:[NSString stringWithFormat:@"%lf",[Globle getInstance].imagelat] forKey:@"maplat"];
    //设备类型，0:android 1:IOS
    [params setObject:[[NSNumber alloc] initWithInt:1] forKey:@"device"];
    //菜单类型，0:出行 1:维修
    [params setObject:[[NSNumber alloc] initWithInt:0] forKey:@"menutype"];
    
    NSString *tempStr = appbase;
    [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].wxBaseServiceURL ServiceName:[tempStr stringByAppendingString:@"/appgetareaweather"] params:params httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result)
     {
         
         if(nil == result)
         {
            
//             UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"加载失败，请确认网络是否开启" delegate:self cancelButtonTitle:@"确 定" otherButtonTitles: nil];
//             [alert show];
         }
         else
         {
             NSDictionary *dic = result;
             NSString *restate = [dic objectForKey:@"restate"];
             if([@"1" isEqualToString:restate])
             {
                 //刷新UI
               //  NSLog(@"tianqitianqi%@",dic);
                 if (nil != dic[@"data"]) {
                     NSDictionary *areaDic = dic[@"data"][@"area"];
                     sectionTitle = @[[NSString stringWithFormat:@"1、该车在%@%@最近一次维修企业是",areaDic[@"province"],areaDic[@"city"]]];
                   //  NSLog(@"%@",areaDic[@"city"]);
                 }
                 
             }
             else
             {
                 NSString *redes = [dic objectForKey:@"redes"];
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:redes delegate:self cancelButtonTitle:@"确 定" otherButtonTitles: nil];
                 [alert show];
             }
         }
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 确认选择
-(void)confirmSelect{
    
    alertView = [[FVCustomAlertView alloc] init];
    [alertView showAlertWithonView:self.view Width:100 height:100 contentView:nil cancelOnTouch:false Duration:-1];
    [self.view addSubview:alertView];
    
    if (companyName == nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"验证车辆信息失败!" message:@"请选择答案!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        [alertView dismiss];
        return;
    }
    
   // NSString *str = @"WDDFH3DB0AJ541602";
    
    NSDictionary *bigDic = [Globle getInstance].loginInfoDic;
    NSDictionary *userDic = [bigDic objectForKey:@"userinfo"];
    NSString *token = [bigDic objectForKey:@"token"];
    
    NSMutableDictionary *bean = [NSMutableDictionary dictionary];
    [bean setValue:userDic[@"userflag"] forKey:@"userflag"];
    [bean setValue:token forKey:@"token"];
    [bean setValue:@"420111111111111111" forKey:@"areaid"];
    [bean setValue:_carNumber forKey:@"carno"];
    [bean setValue:_VINCode forKey:@"carvin"];
    [bean setValue:_engineNumber forKey:@"enginenumber"];
    [bean setValue:companyName forKey:@"companyname"];
    
    [[Globle getInstance].service requestWithServiceIP:WXServiceURL ServiceName:[NSString stringWithFormat:@"%@/appcarapproveanswer",businessapp] params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        NSDictionary *bigDic = result;
        if ([bigDic[@"restate"]isEqualToString:@"1"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"恭喜您，车辆信息验证成功!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }else if ([bigDic[@"restate"]isEqualToString:@"-4"]){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"您一个小时之内给出的答案与实际情况不符，不能车辆认证，请过一个小时再进行车辆认证!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"验证不通过!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
        NSLog(@"%@",bigDic[@"redes"]);
        [alertView dismiss];
    }];
    
}

#pragma mark - tableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-20, 30)];
    lab.font = [UIFont systemFontOfSize:13];
    lab.text = sectionTitle[section];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.backgroundColor = BackColor;
    return lab;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VerSectionOneCell *cell;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"section0"];
    }
    
    if (dataList.count > indexPath.row) {
        cell.optionsLab.text = dataList[indexPath.row];
    }
    cell.lab.text = cellTitle[indexPath.row];
    return cell;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    for (NSInteger i = 0; i < 4; i++) {
        NSIndexPath *CurrentIndexPath = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
        VerSectionOneCell *cell = [tableView cellForRowAtIndexPath:CurrentIndexPath];
        cell.state = 0; //将section内所有row选中状态清空
        cell.selectState.image = [UIImage imageNamed:@"cellUnSelect"];
    }
    
    VerSectionOneCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.state = 1;  //表示选中状态
    cell.selectState.image = [UIImage imageNamed:@"cellSelect"];
    NSArray *array = [cell.optionsLab.text componentsSeparatedByString:@"("];
    companyName = array[0];
  //  NSLog(@"%@",companyName);
    
    
//    cell.selectState.image = [UIImage imageNamed:@"cellUnSelect"];
//    
//    cell.selectState.image = [UIImage imageNamed:@"cellSelect"];
//    
//    cell.selectState.image = [UIImage imageNamed:@"cellUnSelect"];
    
    
   
    
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    VerSectionOneCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//    cell.selectState.image = [UIImage imageNamed:@"cellUnSelect"];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    [self.navigationController popViewControllerAnimated:YES];
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
