//
//  CarDetailViewController.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/15.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "CarDetailViewController.h"
#import "WXTableViewCell.h"
#import "CarDetailViewController.h"
#import "AddCarViewController.h"
#import "CarDetailCell.h"
#import "CZT_IOS_Longrise.pch"
#import "CarDetailInfoModel.h"
#import "CarDetailInfoModel.h"

@interface CarDetailViewController ()
<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *table;
    NSArray *titleAry;
    CarDetailInfoModel *model;
    NSMutableArray *dataAry;
    UIAlertView *deleteAlertView;
}
@end

@implementation CarDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = BackColor;
    self.title = @"车辆详情";
    titleAry = @[@"车辆照片",@"车牌号",@"品牌型号",@"车辆类型",@"使用性质",@"车架号",@"发动机号",@"注册日期",@"发证日期"];
    dataAry = [NSMutableArray array];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 30);
    [rightBtn setTitle:@"添加车辆" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [rightBtn addTarget:self action:@selector(addCar) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    [table registerNib:[UINib nibWithNibName:@"CarDetailCell" bundle:nil] forCellReuseIdentifier:@"CarDetailCell"];

}

//-(void)viewWillAppear:(BOOL)animated{
//    [self loadCarDetailData];
//}

-(void)addCar{
    AddCarViewController *vc = [AddCarViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 加载车辆详情数据
-(void)loadCarDetailData{
    
    NSMutableDictionary *bean = [NSMutableDictionary dictionary];
    
    NSDictionary *bigDic = [Globle getInstance].loginInfoDic;
    NSDictionary *userdic = [bigDic objectForKey:@"userinfo"];
    NSString *token = [bigDic objectForKey:@"token"];
    NSString *userflag = [userdic objectForKey:@"userflag"];
    
    [bean setValue:userflag forKey:@"userflag"];
    [bean setValue:token forKey:@"token"];
    [bean setValue:_Id forKey:@"id"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@/",[Globle getInstance].wxSericeURL,baseapp];
    
    [[Globle getInstance].service requestWithServiceIP:url  ServiceName:@"appcarviewdetil" params:bean httpMethod:@"POST"resultIsDictionary:YES completeBlock:^(id result) {
        
        if (nil != result) {
            
            NSLog(@"车辆详情 %@",[Util objectToJson:result]);
            
            model = [[CarDetailInfoModel alloc]initWithString:[Util objectToJson:result] error:nil];
            NSLog(@"%@",model);
           
            
            [table reloadData];
            
        }
        
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 删除车辆
-(void)deleteThisCar{
    
    deleteAlertView = [[UIAlertView alloc]initWithTitle:nil message:@"确定删除车辆信息？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [deleteAlertView show];
    
    
//    NSString *url = [NSString stringWithFormat:@"%@%@/",[Globle getInstance].wxSericeURL,baseapp];
    
//    [[Globle getInstance].service requestWithServiceIP:url  ServiceName:@"appcarviewdetil" params:bean httpMethod:@"POST"resultIsDictionary:YES completeBlock:^(id result) {
//        
//        if (nil != result) {
//            
//            NSLog(@"车辆详情 %@",[Util objectToJson:result]);
//            
//            model = [[CarDetailInfoModel alloc]initWithString:[Util objectToJson:result] error:nil];
//           
//            
//            [table reloadData];
//        }
//        
//    }];
    
}

#pragma mark - tableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 9;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    CarDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CarDetailCell"];
    cell.leftLab.text = titleAry[indexPath.row];
    
    if (dataAry.count>indexPath.row) {
        cell.rightLab.text = dataAry[indexPath.row];
    }
    
    if (indexPath.row == 0) {
        UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenWidth-90, 10, 80, 60)];
        imageV.image = [UIImage imageNamed:@"img07"];
        [cell.contentView addSubview:imageV];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    backView.backgroundColor = BackColor;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(10, 15, ScreenWidth-20, 50);
    btn.backgroundColor = RGB(17, 137, 232);
    btn.layer.cornerRadius = 5;
    [btn setTitle:@"删除此车" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(deleteThisCar) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:btn];
    return backView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.000001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 80;
    }
    else return 50;
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView == deleteAlertView) {
        if (buttonIndex == 0) {
            NSLog(@"取消删除！");
        }else{
            
            //删除车辆信息
            NSMutableDictionary *bean = [NSMutableDictionary dictionary];
            
            NSDictionary *bigDic = [Globle getInstance].loginInfoDic;
            NSDictionary *userdic = [bigDic objectForKey:@"userinfo"];
            NSString *token = [bigDic objectForKey:@"token"];
            NSString *userflag = [userdic objectForKey:@"userflag"];
            
            [bean setValue:_Id forKey:@"id"];
            [bean setValue:userflag forKey:@"userflag"];
            [bean setValue:token forKey:@"token"];
            
            [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].wxBaseServiceURL ServiceName:[NSString stringWithFormat:@"%@/appdeletecar",appbase] params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
                
                
                if (nil != result) {
                    NSDictionary *returnDic = result;
                    if ([returnDic[@"restate"]isEqualToString:@"1"]) {
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"删除成功！" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                        [alert show];
                        
                    }else{
                        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"删除失败！" message:@"请检查网络！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                        [alert show];
                    }
                    
                }else{
                    NSLog(@"没有数据返回");
                }
                
            }];
        }
        
    }else{
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
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
