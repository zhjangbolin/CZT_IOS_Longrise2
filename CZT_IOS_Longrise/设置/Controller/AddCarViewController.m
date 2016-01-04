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
#import "FVCustomAlertView.h"

@interface AddCarViewController ()
<UIAlertViewDelegate,UISelectListViewDelegate>
{
    UISelectListView *carTypeSelect;
    UISelectListView *carNumSelect;
    UISelectListView *insSelect;
    
    NSMutableArray *carTypeData;
    NSMutableArray *cityData;
    NSMutableArray *insData;
    NSMutableArray *insCode;
    
    NSString *carType;
    NSString *carNumber;
    NSString *insName;
    NSString *insCodeString;
    
    FVCustomAlertView *alertView;
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
    insCode     = [NSMutableArray array];
    
    self.view.backgroundColor = BackColor;
    self.title = @"添加车辆";
    self.nextBtn.layer.cornerRadius = 5;
    [self.nextBtn addTarget:self action:@selector(pushToVerifyInfo) forControlEvents:UIControlEventTouchUpInside];
    
    [self initCarTypeSelectListView];
    [self initCarNumSelectListView];
    [self initInsSelectListView];
}

-(void)viewWillAppear:(BOOL)animated{
    
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
    [carTypeSelect setContentTextAlignment:NSTextAlignmentRight];
    carTypeSelect.backgroundColor = [UIColor whiteColor];
    [carTypeSelect setShowLabelSize:[UIFont systemFontOfSize:14]];
    [carTypeSelect setIcon:[UIImage imageNamed:@"select_input2"]];
    [carTypeSelect setDropWidth:50];
    [_carTypeBackView addSubview:carTypeSelect];
    
}

-(void)initCarNumSelectListView{

    //初始化车牌号select
    carNumSelect = [[UISelectListView alloc]initWithFrame:_carNoSelectBackView.bounds];
    carNumSelect.currentView = self.view;
    carNumSelect.delegate = self;
  //  [carTypeSelect setContentTextAlignment:NSTextAlignmentRight];
    carNumSelect.backgroundColor = [UIColor whiteColor];
    [carNumSelect setIcon:[UIImage imageNamed:@"select_input2"]];
    [carNumSelect setDropWidth:45];
    [_carNoSelectBackView addSubview:carNumSelect];
    
}

-(void)initInsSelectListView{
    
    //初始化保险公司select
    insSelect = [[UISelectListView alloc]initWithFrame:_insSelectBackView.bounds];
    insSelect.currentView = self.view;
    insSelect.delegate = self;
    insSelect.backgroundColor = [UIColor whiteColor];
    [insSelect setContentTextAlignment:NSTextAlignmentRight];
    [insSelect setShowLabelSize:[UIFont systemFontOfSize:14]];
    [insSelect setIcon:[UIImage imageNamed:@"select_input2"]];
    [insSelect setDropWidth:50];
    [_insSelectBackView addSubview:insSelect];
}

#pragma mark - 加载车辆类型列表
-(void)loadCarType{
    
    NSDictionary *bigDic = [Globle getInstance].loginInfoDic;
    NSDictionary *userdic = [bigDic objectForKey:@"userinfo"];
    NSString *token = [bigDic objectForKey:@"token"];
 //   NSLog(@"%@",token);
    NSString *userflag = [userdic objectForKey:@"userflag"];
    
    NSMutableDictionary *bean = [NSMutableDictionary dictionary];
    [bean setValue:userflag forKey:@"userflag"];
    [bean setValue:token forKey:@"token"];
    [bean setValue:@"appcartype" forKey:@"codetype"];
    
    NSString *url = [NSString stringWithFormat:@"%@%@/",[Globle getInstance].wxSericeURL,baseapp];

    [[Globle getInstance].service requestWithServiceIP:url  ServiceName:@"appgetcodevalue" params:bean httpMethod:@"POST"resultIsDictionary:YES completeBlock:^(id result) {

            if (nil != result) {
                
                NSDictionary *bigDic = result;
                NSArray *codeAry = [bigDic objectForKey:@"data"];
                 //           NSLog(@"appcartype%@",result);
               //             NSLog(@"appcartype%@",[Util objectToJson:result]);
             //   NSLog(@"%@",codeAry);
                if (nil != codeAry) {
                    NSLog(@"%@",codeAry);
                    for (int i = 0; i < codeAry.count; i++) {
                        
                        NSDictionary *dic = codeAry[i];
                        NSString *codeValue = [dic objectForKey:@"codevalue"];
                        
                        NSMutableDictionary *codeDic = [[NSMutableDictionary alloc]init];
                        [codeDic setValue:codeValue forKey:@"cartype"];
                        [carTypeData addObject:codeDic ];
                        
                    }
                    [carTypeSelect addArray:carTypeData forKey:@"cartype"];
                }
                
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
    [carNumSelect setShowLabelSize:[UIFont systemFontOfSize:14]];
    [carNumSelect setContentTextAlignment:NSTextAlignmentRight];
}

#pragma mark - 加载保险公司列表
-(void)loadInsurance{
    
    NSDictionary *bigDic = [Globle getInstance].loginInfoDic;
    NSDictionary *userdic = [bigDic objectForKey:@"userinfo"];
    NSString *token = [bigDic objectForKey:@"token"];
   // NSLog(@"%@",token);
    NSString *userflag = [userdic objectForKey:@"userflag"];
    
    NSMutableDictionary *bean = [NSMutableDictionary dictionary];
    [bean setValue:userflag forKey:@"userflag"];
    [bean setValue:token forKey:@"token"];
    [bean setValue:@"1100" forKey:@"areaid"];
    NSString *url = [NSString stringWithFormat:@"%@%@/",[Globle getInstance].wxSericeURL,baseapp];
    
    [[Globle getInstance].service requestWithServiceIP:url  ServiceName:@"appsearchincompanylist" params:bean httpMethod:@"POST"resultIsDictionary:YES completeBlock:^(id result) {
        
        if (nil != result) {
//            NSLog(@"appsearchincompanylist%@",[Util objectToJson:result]);
            SetInsModel *model = [[SetInsModel alloc]initWithString:[Util objectToJson:result] error:nil];
            
            for (int i = 0; i < model.data.count; i++) {
                
                SetInsDataModel *dataModel = model.data[i];
                
                NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
                NSMutableDictionary *dicCode = [NSMutableDictionary dictionary];
                [dic setValue:dataModel.incomname forKey:@"ins"];
                [dicCode setValue:dataModel.incomcode forKey:dataModel.incomname];
                [insData addObject:dic];
                [insCode addObject:dicCode];
            }
            
        }
        
        [insSelect addArray:insData forKey:@"ins"];
    }];
}


#pragma mark - 跳转验证信息页面
-(void)pushToVerifyInfo{
    if (carType.length > 0 && carNumber.length > 0 && insName.length > 0 && _carNum.text.length > 0 && _vinCode.text.length > 0 && _engineNum.text.length > 0) {
        
        alertView = [[FVCustomAlertView alloc] init];
        [alertView showAlertWithonView:self.view Width:100 height:100 contentView:nil cancelOnTouch:false Duration:-1];
        [self.view addSubview:alertView];

        NSDictionary *bigDic = [Globle getInstance].loginInfoDic;
        NSDictionary *userdic = [bigDic objectForKey:@"userinfo"];
        NSString *token = [bigDic objectForKey:@"token"];
      //  NSLog(@"%@",token);
        NSString *userflag = [userdic objectForKey:@"userflag"];
        NSString *carNo = [NSString stringWithFormat:@"%@%@",carNumber,_carNum.text];
        for (NSDictionary *dic in insCode) {
            if ([dic.allKeys containsObject:insName]) {
                insCodeString = dic[insName];
              //  NSLog(@"------------%@",insCodeString);
            }
        }
        
      //  NSString *str = @"WDDFH3DB0AJ541602";
     
        NSMutableDictionary *bean = [NSMutableDictionary dictionary];
        [bean setValue:userflag forKey:@"userflag"];
        [bean setValue:carNo forKey:@"carno"];
       // [bean setValue:_vinCode.text forKey:@"identificationnum"];
        [bean setValue:_vinCode.text forKey:@"identificationnum"];
        [bean setValue:_engineNum.text forKey:@"enginenumber"];
        [bean setValue:carType forKey:@"cartype"];
        [bean setValue:insName forKey:@"incomname"];
        [bean setValue:insCodeString forKey:@"incomcode"];
        [bean setValue:token forKey:@"token"];
        
        [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].wxBaseServiceURL ServiceName:[NSString stringWithFormat:@"%@/appaddacccar",appbase] params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
            if (nil != result) {
                NSDictionary *bigDic = result;
              //  NSLog(@"dic=   %@",bigDic);
                if ([bigDic[@"restate"]isEqualToString:@"1"]) {
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"车辆添加成功" message:@"是否需要现在验证车辆信息" delegate:self cancelButtonTitle:@"稍后验证" otherButtonTitles: @"立即验证",nil];
                    [alert show];
                }else if ([bigDic[@"restate"]isEqualToString:@"-9"]){
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"车辆添加失败" message:@"请输入正确的车牌号!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                }else if ([bigDic[@"restate"]isEqualToString:@"-16"]){
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"车辆添加失败" message:@"请输入正确的车辆识别代号(VIN)!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                }else if ([bigDic[@"restate"]isEqualToString:@"-11"]||[bigDic[@"restate"]isEqualToString:@"-12"]){
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"车辆添加失败" message:@"车牌号已在该用户名下!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                }
                else{
                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"车辆添加失败" message:@"请核对好信息再填写!" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                    [alert show];
                }
                NSLog(@"%@",bigDic[@"redes"]);
                NSLog(@"%@",bigDic[@"restate"]);
            }else{
                NSLog(@"没有数据返回！");
            }
            [alertView dismiss];
            
        }];
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"车辆添加失败" message:@"请填写好您的全部信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
    
    
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
        carType = dic[@"cartype"];
       // NSLog(@"%@",carType);
    }
    else if (selectListView == carNumSelect)
    {
        carNumber = dic[@"cities"];
        
    }
    else{
        insName = dic[@"ins"];
    }
    
    
}


#pragma mark - UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 0) {
        NSLog(@"0");
    }
    else {
        VerifyInfoViewController *vc = [VerifyInfoViewController new];
        vc.carNumber = [NSString stringWithFormat:@"%@%@",carNumber,_carNum.text];
        vc.VINCode = _vinCode.text;
        vc.engineNumber = _engineNum.text;
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
