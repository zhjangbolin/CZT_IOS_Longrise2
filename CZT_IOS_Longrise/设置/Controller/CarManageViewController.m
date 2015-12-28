//
//  CarManageViewController.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/12.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "CarManageViewController.h"
#import "AddCarViewController.h"
#import "WXTableViewCell.h"
#import "CarDetailViewController.h"
#import "HealthRecordViewController.h"
#import "AppDelegate.h"
#import "WXModel.h"
#import "CarModel.h"
#import <MJRefresh.h>
@interface CarManageViewController ()
<UITableViewDataSource,UITableViewDelegate,WXTableViewCellDelegate>
{
    UITableView *table;
    NSMutableArray *carDataArray;
    NSInteger carPage;
    NSMutableDictionary *carBean;
    WXModel *wxModel;
}
@end

@implementation CarManageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"车辆管理";
    
    carDataArray = [NSMutableArray array];
    carBean = [NSMutableDictionary dictionary];
    carPage = 1;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 60, 30);
    [rightBtn setTitle:@"添加车辆" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [rightBtn addTarget:self action:@selector(addCar) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self refreshCarData];
        [table.mj_header endRefreshing];
        
    }];
    
    table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self loadMoreCarData];
        [table.mj_footer endRefreshing];
        
    }];
    
    UINib *nib1 = [UINib nibWithNibName:@"WXTableViewCell" bundle:nil];
    [table registerNib:nib1 forCellReuseIdentifier:@"WXTableViewCell"];
    
  //  [self loadCarData];
}

-(void)viewWillAppear:(BOOL)animated{
    carDataArray = [NSMutableArray array];
    [self loadCarData];
}


-(void)addCar{
    AddCarViewController *vc = [AddCarViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)jumpToHealth{
     HealthRecordViewController *vc = [HealthRecordViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreatevd.
}

#pragma mark - 查询车辆列表
-(void)loadCarData{
    
    NSDictionary *bigDic = [Globle getInstance].loginInfoDic;
    NSLog(@"bigdic%@",bigDic);
    NSDictionary *userdic = [bigDic objectForKey:@"userinfo"];
    NSString *token = [bigDic objectForKey:@"token"];
    NSString *userflag = [userdic objectForKey:@"userflag"];
    
    [carBean setValue:userflag forKey:@"userflag"];
    [carBean setValue:token forKey:@"token"];
    [carBean setValue:[NSNumber numberWithInteger:carPage] forKey:@"pagenum"];
    [carBean setValue:@"5" forKey:@"pagesize"];
    
    NSLog(@"CarManagerBean%@",carBean);
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在加载";
    
    NSString *url = [NSString stringWithFormat:@"%@%@/",[Globle getInstance].wxSericeURL,businessapp];
    NSLog(@"url%@",url);
    [[Globle getInstance].service requestWithServiceIP:url ServiceName:@"appsearchcarlist" params:carBean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        [hud hide:YES afterDelay:0];
//        NSLog(@"result%@",result);
        if (nil != result) {
            NSDictionary *bigDic = result;
            NSLog(@"%@",bigDic);
            NSString *json = [Util objectToJson:result];
            NSLog(@"CarManage车辆数据%@",json);
            wxModel= [[WXModel alloc]initWithString:json error:nil];
            NSLog(@"CarManage车辆模型个数%ld",wxModel.data.count);
            [carDataArray addObjectsFromArray:wxModel.data];
            [table reloadData];
        }
    } ];
}

#pragma mark - 刷新车辆维修记录
-(void)refreshCarData{
    
    [carDataArray removeAllObjects];
    [table reloadData];
    carPage = 1;
    [carBean setValue:[NSNumber numberWithInteger:carPage] forKey:@"pagenum"];
    [self loadCarData];
}

#pragma mark - 加载更多车辆维修记录
-(void)loadMoreCarData{
    
    carPage ++;
    if (carPage>4) {
        table.mj_footer.hidden = YES;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"没有更多数据啦";
        [hud hide:YES afterDelay:2.0];
    }
    else{
        [carBean setValue:[NSNumber numberWithInteger:carPage] forKey:@"pagenum"];
        [self loadCarData];
    }
}

#pragma mark - tableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return carDataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    /**
     *  车辆管理的cell可以push2个控制器
     *  点击cellpush车辆详情 点击查询健康档案push健康档案
     */
    WXTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WXTableViewCell"];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    [cell.checkHealth addTarget:self action:@selector(jumpToHealth) forControlEvents:UIControlEventTouchUpInside];
    if (carDataArray.count > indexPath.section) {
        CarModel *model = carDataArray[indexPath.section];
        cell.CellCarNo = model.carno;
        [cell setUIWithInfo:model];
    }
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 130*SCALE;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.000001;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CarDetailViewController *vc = [CarDetailViewController new];
    
    CarModel *model = carDataArray[indexPath.section];
    if (nil != model.Id) {
        vc.Id = model.Id;
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark - cell的代理方法
-(void)pushToNextViewControllerWith:(NSString *)carNo{
    HealthRecordViewController *vc = [HealthRecordViewController new];
    vc.carNo = carNo;
    [self.navigationController pushViewController:vc animated:YES];
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
