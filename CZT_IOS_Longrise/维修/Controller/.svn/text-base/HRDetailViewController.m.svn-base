//
//  HRDetailViewController.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/12.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "HRDetailViewController.h"
#import "HRDetailHeaderView.h"
#import "HRDetailSectionZeroCell.h"
#import "HRDetailSectionOneCell.h"
#import "HRDetailSectionTwoCell.h"
#import "EvaluateViewController.h"
#import "ComplainViewController.h"
#import <MJRefresh.h>
#import "HRDetailModel.h"
@interface HRDetailViewController ()
<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
    HRDetailHeaderView *header;
    UIButton *evaluateBtn;
    UIButton *complainBtn;
    
    NSMutableArray *serviceItemsAry;
    HRDetailDataModel *dataModel;
    EvaluateModel *evaModel;
}
@end

@implementation HRDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"健康档案详情";
    serviceItemsAry = [NSMutableArray array];
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-40) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight-104, ScreenWidth, 40)];
    bottomView.backgroundColor = RGB(245, 245, 245);
    [self.view addSubview:bottomView];
    
    //添加底部按钮
    evaluateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    evaluateBtn.frame = CGRectMake(ScreenWidth-90, 5, 80, 30);
    evaluateBtn.backgroundColor = [UIColor whiteColor];
    evaluateBtn.layer.cornerRadius = 3;
    evaluateBtn.layer.borderWidth = 1;
    evaluateBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [evaluateBtn setTitle:@"评价" forState:UIControlStateNormal];
    [evaluateBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [bottomView addSubview:evaluateBtn];
    
    complainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    complainBtn.frame = CGRectMake(evaluateBtn.frame.origin.x-90, 5, 80, 30);
    complainBtn.backgroundColor = [UIColor whiteColor];
    complainBtn.layer.cornerRadius = 3;
    complainBtn.layer.borderWidth = 1;
    complainBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [complainBtn setTitle:@"投诉" forState:UIControlStateNormal];
    [complainBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [bottomView addSubview:complainBtn];
    
    //添加按钮点击事件
    [complainBtn addTarget:self action:@selector(clickComplainBtn) forControlEvents:UIControlEventTouchUpInside];
    [evaluateBtn addTarget:self action:@selector(clickEvaluateBtn) forControlEvents:UIControlEventTouchUpInside];
    
    //添加头部视图
    header = [[NSBundle mainBundle] loadNibNamed:@"HRDetailHeaderView" owner:nil options:nil][0];
    header.frame = CGRectMake(0, 0, ScreenWidth, 100*SCALE);
    if (nil !=  _model ) {
        [header setUIWithInfo:self.model];
    }
    table.tableHeaderView = header;
    
    //预先注册Cell
    [table registerNib:[UINib nibWithNibName:@"HRDetailSectionZeroCell" bundle:nil] forCellReuseIdentifier:@"HRDetailSectionZeroCell"];
    
    [table registerNib:[UINib nibWithNibName:@"HRDetailSectionOneCell" bundle:nil] forCellReuseIdentifier:@"HRDetailSectionOneCell"];
    
    [table registerNib:[UINib nibWithNibName:@"HRDetailSectionTwoCell" bundle:nil] forCellReuseIdentifier:@"HRDetailSectionTwoCell"];
    
    [self loadHealthRecordDetailData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 加载健康档案详情数据
-(void)loadHealthRecordDetailData{
    
    NSMutableDictionary *bean = [NSMutableDictionary dictionary];
    
    NSDictionary *bigDic = [Globle getInstance].loginInfoDic;
    //    NSDictionary *userdic = [bigDic objectForKey:@"userinfo"];
    NSString *token = [bigDic objectForKey:@"token"];
    //    NSString *userflag = [userdic objectForKey:@"userflag"];
    NSString *areaid = [Globle getInstance].areaid;
    
    [bean setValue:@"huxl" forKey:@"userflag"];
    [bean setValue:token forKey:@"token"];
    [bean setValue:areaid forKey:@"areaid"];
    [bean setValue:_Id forKey:@"id"];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"正在加载";
    
    NSString *url = [NSString stringWithFormat:@"%@%@/",[Globle getInstance].wxSericeURL,businessapp];
    
//    NSLog(@"健康档案bean%@",bean);
    
    [[Globle getInstance].service requestWithServiceIP:url ServiceName:@"appsearchrecord" params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        [hud hide:YES afterDelay:0];
        
        if (nil != result) {
            NSString *json = [Util objectToJson:result];
//            NSLog(@"健康档案详情%@",json);
            HRDetailModel *model = [[HRDetailModel alloc]initWithString:json error:nil];
            dataModel = model.data[0];
            NSArray *serviceitem = dataModel.serviceitems;
            SeviceItemsModel *serviceitemModel = serviceitem[0];
            evaModel = serviceitemModel.belcipcarownerevaluate;
            
            //手动解析repairname
            NSDictionary *dic = result;
            NSArray *data = [dic objectForKey:@"data"];
            NSDictionary *dataDic = data[0];
            NSArray *seviceItems = [dataDic objectForKey:@"serviceitems"];
            NSDictionary *smallDic = seviceItems[0];
            NSArray *lciptimesheet = [smallDic objectForKey:@"lciptimesheet"];
            for (int i=0; i<lciptimesheet.count; i++) {
                NSDictionary *repairDic = lciptimesheet[i];
                NSString *repairname = [repairDic objectForKey:@"repairname"];
                NSLog(@"repairname%@",repairname);
                [serviceItemsAry addObject:repairname];
            }
            
            [table reloadData];
        }
    } ];
}

#pragma mark - 评价和投诉按钮点击事件
-(void)clickComplainBtn{

    ComplainViewController *vc = [ComplainViewController new];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)clickEvaluateBtn{

    EvaluateViewController *vc = [EvaluateViewController new];
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
    
}


#pragma mark - tableView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        HRDetailSectionZeroCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HRDetailSectionZeroCell"];
        
        [cell setUIWithInfo:dataModel andData:serviceItemsAry];
        
        NSLog(@"serviceItemsAry%ld",serviceItemsAry.count);
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    else if (indexPath.section == 1){
    
        HRDetailSectionOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HRDetailSectionOneCell"];
        [cell setUIWithInfo:dataModel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    else{
        
        HRDetailSectionTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HRDetailSectionTwoCell"];
        [cell setUIWithInfo:evaModel];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    
    
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return @"维修信息";
        
    }
    else if (section == 1){
        
        return @"维修费用";
        
    }
    else{
        
        return @"评价信息";
        
    }
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return 440*SCALE;
        
    }
    else if (indexPath.section == 1){
        
        return 100*SCALE;
        
    }
    else{
        
        return 310*SCALE;
        
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
