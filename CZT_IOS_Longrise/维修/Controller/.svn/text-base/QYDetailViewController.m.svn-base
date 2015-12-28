//
//  QYDetailViewController.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/10.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "QYDetailViewController.h"
#import "HeaderView.h"
#import "SectionOneCell.h"
#import "SectionTwoViewCell.h"
#import "CZT_IOS_Longrise.pch"
#import "UIImageView+WebCache.h"
#import "DetailModel.h"
#import "SectionTwoHeaderView.h"
@interface QYDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *table;
    HeaderView *header;
    NSArray *imgCount;
    CGFloat imgHeight;
    
    NSMutableArray *evaluateArray;
    DetailInfoModel *infoModel;
}
@end

@implementation QYDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"_companyId%@",_companyId);
    NSLog(@"_areaId%@",_areaId);
    
    self.view.backgroundColor = [UIColor whiteColor];
    evaluateArray = [NSMutableArray array];
    
    imgCount = @[@0,@3,@0];
    
    /**
     *  暂时隐藏分享按钮
     */
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(0, 0, 30, 30);
//    [btn setImage:[UIImage imageNamed:@"icon02"] forState:UIControlStateNormal];
//    
//    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
//    self.navigationItem.rightBarButtonItem = barBtn;
    
    header = [[NSBundle mainBundle] loadNibNamed:@"HeaderView" owner:nil options:nil][0];
    header.frame = CGRectMake(0, 0, ScreenWidth, 260*SCALE);
    
    table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.tableHeaderView = header;
    [self.view addSubview:table];
    

    [table registerNib:[UINib nibWithNibName:@"SectionOneCell" bundle:nil] forCellReuseIdentifier:@"SectionOneCell"];
    
    [table registerNib:[UINib nibWithNibName:@"SectionTwoViewCell" bundle:nil] forCellReuseIdentifier:@"SectionTwoViewCell"];
    
//    [AppDelegate storyBoradAutoLay:self.view];
    
    [self loadEnterpriseDetailInfoData];
//    [self loadEnterpriseEvaluateData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 加载企业信息详情
-(void)loadEnterpriseDetailInfoData{
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSMutableDictionary *bean = [NSMutableDictionary dictionary];
    //只有这一组有数据
    NSLog(@"areaid%@",_areaId);
    NSLog(@"comid%@",_companyId);
    
    [bean setValue:@"420100000000000000" forKey:@"areaid"];
    [bean setValue:@"659696779d124f77806bac4e3c08f558" forKey:@"lcipcompanyid"];
    [bean setValue:@"1" forKey:@"pagenum"];
    [bean setValue:@"2" forKey:@"pagesize"];
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@/",[Globle getInstance].wxSericeURL,businessapp];
    
    [[Globle getInstance].service requestWithServiceIP:url ServiceName:@"appsearchcompanyinfo" params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        [hud hide:YES afterDelay:0];
        
        NSLog(@"DetailResult%@",[Util objectToJson:result]);
        if (nil != result) {
            DetailModel *model = [[DetailModel alloc]initWithString:[Util objectToJson:result] error:nil];
            /**
             *  头视图和主营范围模型
             */
            infoModel = model.data.companyinfo;
            [header setUIWithInfo:infoModel];
            
            DetailEvaluateModel *evaModel = model.data.companyevaluate;
            /**
             *  评价模型数组
             */
            evaluateArray = [NSMutableArray arrayWithArray:evaModel.data];
            
            
            [table reloadData];
        }
    }];
}


-(void)loadEnterpriseEvaluateData{
    
    NSMutableDictionary *bean = [NSMutableDictionary dictionary];
    [bean setValue:@"420100000000000000" forKey:@"areaid"];
    [bean setValue:@"659696779d124f77806bac4e3c08f558" forKey:@"lcipcompanyid"];
//    [bean setValue:@"883ed81fa64d4e45ba2db65f30d0d1da" forKey:@"lcipcompanyid"];
    
    
    [bean setValue:@"1" forKey:@"pagenum"];
    [bean setValue:@"2" forKey:@"pagesize"];
    
    [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].wxSericeURL ServiceName:@"appsearchfixcomevaluate" params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
//        NSLog(@"EvaluateResult%@",[Util objectToJson:result]);
//        NSLog(@"EvaluateResult%@",result);
    }];
}


#pragma mark - tabelView Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    else{
        return evaluateArray.count;
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        SectionOneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SectionOneCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        [cell setUIWithInfo:infoModel];
        return cell;
        
    }
    else{
        SectionTwoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SectionTwoViewCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        EvaluateResultModel *model = evaluateArray[indexPath.row];
        [cell setUIWithInfo:model];
        return cell;

    }
    
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"主营范围";
    }
    else{
        return @"评价";
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        SectionTwoHeaderView *twoHeader = [[NSBundle mainBundle] loadNibNamed:@"SectionTwoHeaderView" owner:nil options:nil][0];
        twoHeader.total.text = [NSString stringWithFormat:@"评价(%@)",infoModel.peoplenumber];
        twoHeader.good.text = [NSString stringWithFormat:@"好评(%@)",infoModel.ratenum];
        twoHeader.middle.text = [NSString stringWithFormat:@"中评(%@)",infoModel.middlenum];
        twoHeader.bad.text = [NSString stringWithFormat:@"差评(%@)",infoModel.badnum];
        
        return twoHeader;
    }
    else return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 100*SCALE;
    }
    else{

        if ([imgCount[indexPath.row] integerValue] > 0) {
            imgHeight = 60;
        }
        else{
            imgHeight = 0;
        }
        return (130+imgHeight)*SCALE;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
