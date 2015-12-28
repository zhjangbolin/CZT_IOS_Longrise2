//
//  AddCarViewController.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/10.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "AddCarViewController.h"
#import "VerifyInfoViewController.h"
#import "CZT_IOS_Longrise.pch"
#import "UISelectListView.h"
#import "SetInsModel.h"
@interface AddCarViewController ()
<UIAlertViewDelegate,UISelectListViewDelegate>
{
    UISelectListView *carTypeSelect;
    UISelectListView *carNumSelect;
    UISelectListView *insSelect;
    
    NSMutableArray *carTypeData;
    NSMutableArray *cityData;
    NSMutableArray *insData;
}
@end

@implementation AddCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [AppDelegate storyBoradAutoLay:self.view];
    carTypeData = [NSMutableArray array];
    cityData    = [NSMutableArray array];
    insData     = [NSMutableArray array];
    
    self.view.backgroundColor = BackColor;
    self.title = @"添加车辆";
    self.nextBtn.layer.cornerRadius = 5;
    [self.nextBtn addTarget:self action:@selector(pushToVerifyInfo) forControlEvents:UIControlEventTouchUpInside];
    
    [self initCarTypeSelectListView];
    [self initCarNumSelectListView];
    [self initInsSelectListView];
    
    [self loadCarType];
    [self loadCarCities];
    [self loadInsurance];
    
}


#pragma mark - 初始化UISelectListView
-(void)initCarTypeSelectListView{
    
    //初始化车辆类型select
    carTypeSelect = [[UISelectListView alloc]initWithFrame:_carTypeBackView.bounds];
    carTypeSelect.currentView = self.view;
    carTypeSelect.delegate = self;
    carTypeSelect.backgroundColor = [UIColor whiteColor];
    
    [carTypeSelect setIcon:[UIImage imageNamed:@"select_input"]];
    [carTypeSelect setDropWidth:100];
    [_carTypeBackView addSubview:carTypeSelect];
    
}

-(void)initCarNumSelectListView{

    //初始化车牌号select
    carNumSelect = [[UISelectListView alloc]initWithFrame:_carNoSelectBackView.bounds];
    carNumSelect.currentView = self.view;
    carNumSelect.delegate = self;
    carNumSelect.backgroundColor = [UIColor whiteColor];
    
    [carNumSelect setIcon:[UIImage imageNamed:@"select_input"]];
    [carNumSelect setDropWidth:50];
    [_carNoSelectBackView addSubview:carNumSelect];
}

-(void)initInsSelectListView{
    
    //初始化保险公司select
    insSelect = [[UISelectListView alloc]initWithFrame:_insSelectBackView.bounds];
    insSelect.currentView = self.view;
    insSelect.delegate = self;
    insSelect.backgroundColor = [UIColor whiteColor];
    
    [insSelect setIcon:[UIImage imageNamed:@"select_input"]];
    [insSelect setDropWidth:50];
    [_insSelectBackView addSubview:insSelect];
}

#pragma mark - 加载车辆类型列表
-(void)loadCarType{
    
    NSMutableDictionary *bean = [NSMutableDictionary dictionary];
    [bean setValue:@"appcartype" forKey:@"codetype"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@/",[Globle getInstance].wxSericeURL,baseapp];
    
    [[Globle getInstance].service requestWithServiceIP:url  ServiceName:@"appgetcodevalue" params:bean httpMethod:@"POST"resultIsDictionary:YES completeBlock:^(id result) {
        
        if (nil != result) {
            
            NSDictionary *bigdic = result;
            NSArray *codeAry = [bigdic objectForKey:@"data"];
            //            NSLog(@"appcartype%@",result);
            //            NSLog(@"appcartype%@",[Util objectToJson:result]);
            
            for (int i = 0; i < codeAry.count; i++) {
                
                NSDictionary *dic = codeAry[i];
                NSString *codeValue = [dic objectForKey:@"codevalue"];
                
                NSMutableDictionary *codeDic = [[NSMutableDictionary alloc]init];
                [codeDic setValue:codeValue forKey:@"cartype"];
                [carTypeData addObject:codeDic ];
                
            }
            [carTypeSelect addArray:carTypeData forKey:@"cartype"];
        }
    }];
}

#pragma mark - 加载车牌号列表
- (void)loadCarCities
{
    
    NSArray *cityArr = @[@"京",@"津",@"沪",@"渝",@"冀",@"豫",@"云",@"辽",@"黑",@"湘",@"皖",@"鲁",@"新",@"苏",@"浙",@"赣",@"鄂",@"桂",@"甘",@"晋",@"蒙",@"陕",@"吉",@"闽",@"贵",@"粤",@"青",@"藏",@"川",@"宁",@"琼"];
    
    for (int i = 0; i < cityArr.count; i++) {
        
        NSMutableDictionary  *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:cityArr[i] forKey:@"cities"];
        [cityData addObject:dic];
    }

    [carNumSelect addArray:cityData forKey:@"cities"];
}

#pragma mark - 加载保险公司列表
-(void)loadInsurance{
    NSMutableDictionary *bean = [NSMutableDictionary dictionary];
    [bean setValue:@"1100" forKey:@"areaid"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@/",[Globle getInstance].wxSericeURL,baseapp];
    
    [[Globle getInstance].service requestWithServiceIP:url  ServiceName:@"appsearchincompanylist" params:bean httpMethod:@"POST"resultIsDictionary:YES completeBlock:^(id result) {
        
        if (nil != result) {
            NSLog(@"appsearchincompanylist%@",[Util objectToJson:result]);
            SetInsModel *model = [[SetInsModel alloc]initWithString:[Util objectToJson:result] error:nil];
            
            for (int i = 0; i < model.data.count; i++) {
                
                SetInsDataModel *dataModel = model.data[i];
                
                NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                [dic setValue:dataModel.incomname forKey:@"ins"];
                [insData addObject:dic];
            }
            
        }
        
        [insSelect addArray:insData forKey:@"ins"];
    }];
}


#pragma mark - 跳转验证信息页面
-(void)pushToVerifyInfo{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"车辆添加成功" message:@"是否需要现在验证车辆信息" delegate:self cancelButtonTitle:@"稍后验证" otherButtonTitles: @"立即验证",nil];
    [alert show];
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 下拉菜单
-(void)selectListView:(UISelectListView *)selectListView index:(NSUInteger)index content:(NSDictionary *)dic
{
    if (selectListView == carTypeSelect) {
//        carTypeData = dic[@"cities"];
    }
    else if (selectListView == carNumSelect)
    {
//        cityData = dic[@"cities"];
        
    }
    else{
        
    }
    
    
}


#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 0) {
        NSLog(@"0");
    }
    else {
        VerifyInfoViewController *vc = [VerifyInfoViewController new];
        [self.navigationController pushViewController:vc animated:YES];
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
