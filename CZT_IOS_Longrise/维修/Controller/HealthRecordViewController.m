//
//  HealthRecordViewController.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/12.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "HealthRecordViewController.h"
#import "HealthRecordCell.h"
#import "HRDetailViewController.h"
#import "ComplainViewController.h"
#import "EvaluateViewController.h"
#import "AppDelegate.h"
#import <MJRefresh.h>
#import "HealthRecordModel.h"
@interface HealthRecordViewController ()
<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
    NSInteger page;
    NSMutableArray *hrDataArray;
    NSMutableDictionary *bean;
}
@end

@implementation HealthRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [AppDelegate storyBoradAutoLay:self.view];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"健康档案";
    page = 1;
    hrDataArray = [NSMutableArray array];
    bean = [NSMutableDictionary dictionary];
    
    table = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    UINib *nib1 = [UINib nibWithNibName:@"HealthRecordCell" bundle:nil];
    [table registerNib:nib1 forCellReuseIdentifier:@"HealthRecordCell"];
    
    table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
//        [self refreshCarData];
        [table.mj_header endRefreshing];
        
    }];
    
    table.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [self loadMoreCarData];
        [table.mj_footer endRefreshing];
    }];
    
    [self loadHealthRecordData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

#pragma mark - 加载健康档案数据
-(void)loadHealthRecordData{
    NSDictionary *bigDic = [Globle getInstance].loginInfoDic;
    NSDictionary *userdic = [bigDic objectForKey:@"userinfo"];
    NSString *token = [bigDic objectForKey:@"token"];
   // NSString *userflag = [userdic objectForKey:@"userflag"];
    NSString *areaid = [Globle getInstance].areaid;
    
    [bean setValue:@"huxl" forKey:@"userflag"];
    [bean setValue:token forKey:@"token"];
    [bean setValue:[NSNumber numberWithInteger:page] forKey:@"pagenum"];
    [bean setValue:@"5" forKey:@"pagesize"];
    [bean setValue:_carNo forKey:@"carno"];
    [bean setValue:areaid forKey:@"areaid"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在加载";
    
    NSString *url = [NSString stringWithFormat:@"%@%@/",[Globle getInstance].wxSericeURL,businessapp];
    
    NSLog(@"健康档案bean%@",bean);
    
    [[Globle getInstance].service requestWithServiceIP:url ServiceName:@"appsearchrecordlist" params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        [hud hide:YES afterDelay:0];
        if (nil != result) {
            NSString *json = [Util objectToJson:result];
            NSLog(@"健康档案%@",json);
            HealthRecordModel *model = [[HealthRecordModel alloc]initWithString:json error:nil];
            [hrDataArray addObjectsFromArray:model.data];
            [table reloadData];
        }
    } ];
}

#pragma mark - 刷新健康档案
-(void)refreshCarData{
    
    [hrDataArray removeAllObjects];
    [table reloadData];
    page = 1;
    [bean setValue:[NSNumber numberWithInteger:page] forKey:@"pagenum"];
    [self loadHealthRecordData];
}

#pragma mark - 加载更多健康档案
-(void)loadMoreCarData{
    
    page ++;
    if (page>4) {
        table.mj_footer.hidden = YES;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"没有更多数据啦";
        [hud hide:YES afterDelay:2.0];
    }
    else{
        [bean setValue:[NSNumber numberWithInteger:page] forKey:@"pagenum"];
        [self loadHealthRecordData];
    }
}

#pragma mark - 评价和投诉按钮点击事件
-(void)clickComplainBtn{
    
    ComplainViewController *vc = [ComplainViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickEvaluateBtn{
    
    EvaluateViewController *vc = [EvaluateViewController new];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - tableView Delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return hrDataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HealthRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HealthRecordCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    HRDataModel *model = hrDataArray[indexPath.row];
    [cell setUIWithInfo:model];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 95*SCALE;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.000001;
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
    
    HRDetailViewController *vc = [HRDetailViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    HRDataModel *model = hrDataArray[indexPath.row];
    NSLog(@"hrDataArray%ld",hrDataArray.count);
    
    /**
     * 正向传值，当model不为空时，将model.Id和头部视图model传给push的控制器
     */
    if (nil != model.Id ) {
        vc.model = model;
        vc.Id = model.Id;
    }
    
    UIBarButtonItem *returnButtonItem = [[UIBarButtonItem alloc] init];
    returnButtonItem.title = @"";
    self.navigationItem.backBarButtonItem = returnButtonItem;
    
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
