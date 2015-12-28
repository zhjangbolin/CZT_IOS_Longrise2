//
//  PartiesConcernedController.m
//  CZT_IOS_Longrise
//
//  Created by OSch on 15/12/11.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "PartiesConcernedController.h"
#import "UISelectListView.h"
#import "Globle.h"
#import "VerifyINfimationController.h"

@interface PartiesConcernedController ()<UIAlertViewDelegate>
{
    NSString *cities;
    NSString *companies;
}
@property (strong, nonatomic) NSArray *carCitiesData;

@end

@implementation PartiesConcernedController

- (NSArray *)carCitiesData
{
    if (_carCitiesData == nil) {
        _carCitiesData = [NSArray array];
    }
    return _carCitiesData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"当事人信息";
    
    
    [self loadCompany];
    
    [self loadCarCities];
}
#pragma mark 车牌省市
- (void)loadCarCities
{
    //车牌省市
    NSArray *cityArr = [NSArray array];
    cityArr = @[@"京",@"津",@"沪",@"渝",@"冀",@"豫",@"云",@"辽",@"黑",@"湘",@"皖",@"鲁",@"新",@"苏",@"浙",@"赣",@"鄂",@"桂",@"甘",@"晋",@"蒙",@"陕",@"吉",@"闽",@"贵",@"粤",@"青",@"藏",@"川",@"宁",@"琼"];
    
    
    NSMutableArray *citydata = [NSMutableArray array];
    for (int i = 0; i < cityArr.count; i++) {
        
        NSMutableDictionary  *dic = [[NSMutableDictionary alloc] init];
        [dic setValue:cityArr[i] forKey:@"cities"];
        [citydata addObject:dic];
    }
    self.carCitiesData = citydata;
    
    self.infoView.layer.masksToBounds = YES;
    self.infoView.layer.cornerRadius = 2;
    
   
    
}
#pragma mark 投保公司
-(void)loadCompany
{
    NSDictionary *userinfo = [[Globle getInstance].loginInfoDic objectForKey:@"userinfo"];
    self.phoneNumber.text = userinfo[@"mobilephone"];
    
    NSMutableDictionary *bean1 = [[NSMutableDictionary alloc] init];
    [bean1 setValue:[Globle getInstance].loadDataName forKey:@"username"];
    [bean1 setValue:[Globle getInstance].loadDataPass forKey:@"password"];
    [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].serviceURL ServiceName:[NSString stringWithFormat:@"%@/zdsearchallinscompanylist",kckpzcslrest] params:bean1 httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        [self setSeletViewCompanyData:result[@"data"]];
        
    } ];
}

#pragma mark 下拉菜单
-(void)selectListView:(UISelectListView *)selectListView index:(NSUInteger)index content:(NSDictionary *)dic
{
    if (selectListView == carSelectCities) {
        cities = dic[@"cities"];
    }
    if (selectListView == usSelectCompany)
    {
        companies = dic[@"inscomname"];
        self.usCompanyCode = dic[@"inscomcode"];
        
    }
   
    
}
-(void)setSeletViewCompanyData:(NSArray *)array
{
    //    if (self.reciveCarNumber.length) {
    
    //显示对应的投保公司
//    for (int i = 0; i < array.count; i++) {
//        if ([self.usCompanyName isEqualToString:array[i]]) {
//            companySelectIndex = i;
//        }
//    }
    //    }
    //    else
    //    {
    //        carCitiesSelectIndex = 0;
    //        companySelectIndex = 0;
    //    }
    
    CGFloat top = 8;
    CGFloat left = 5;
    CGFloat bottom = 8;
    CGFloat right = 5;
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    UIImage *backLine = [[UIImage imageNamed:@"select_line"] resizableImageWithCapInsets:insets];
    
    self.driverName.background = backLine;
    self.usPHBackViewLine.image = backLine;
    self.carBackViewLine.image = backLine;
    self.driverNumber.background = backLine;
    
    
    //本方 车牌号
    self.carCityiesView.userInteractionEnabled = YES;
    carSelectCities  = [[UISelectListView alloc]initWithFrame:self.carCityiesView.bounds];
    carSelectCities.currentView = self.view;
    carSelectCities.delegate = self;
    
    [carSelectCities addArray:self.carCitiesData forKey:@"cities"];
    carSelectCities.backgroundColor = [UIColor whiteColor];
    [carSelectCities setIcon:[UIImage imageNamed:@"select_input"]];
    [carSelectCities setDropWidth:50];
    [self.carCityiesView addSubview:carSelectCities];
    
    usSelectCompany = [[UISelectListView alloc]initWithFrame:CGRectMake(0, 0, self.companyView.bounds.size.width, self.companyView.bounds.size.height)];
    usSelectCompany.currentView = self.view;
    usSelectCompany.delegate = self;
    usSelectCompany.titleLabel.font = [UIFont systemFontOfSize:13];
    [usSelectCompany addArray:array forKey:@"inscomname"];
    usSelectCompany.backgroundColor = [UIColor whiteColor];
    [usSelectCompany setBackgroundImage:backLine forState:UIControlStateNormal];
    [usSelectCompany setIcon:[UIImage imageNamed:@"select_input"]];
    [usSelectCompany setDropWidth:50];
    [self.companyView addSubview:usSelectCompany];
    
    
   
    
    
}
#pragma mark 下一步
- (IBAction)nextStep:(id)sender {
    
    if (!self.driverName.text.length || !self.crNumber.text.length || !cities || !companies || !self.phoneNumber.text.length || !self.driverNumber.text.length )
    {
        [self dataCountTwoJudgment];
        
    }
    else
    {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Verify" bundle:nil];
        VerifyINfimationController *parties = [storyboard instantiateViewControllerWithIdentifier:@"VerifyID"];
        parties.hidesBottomBarWhenPushed = YES;
        [self passInfomation:parties];
        [self.navigationController pushViewController:parties animated:YES];
    }
    
    
}


-(void)passInfomation:(VerifyINfimationController *)VC
{
    VC.usUserName = self.driverName.text;
    VC.appcaseno = self.appcaseno;
    VC.usCarNumber = [NSString stringWithFormat:@"%@%@",cities,self.crNumber.text];
    VC.usCompanyName = companies;
    VC.usPhoneNumber = self.phoneNumber.text;
    VC.usDriverNumber = self.driverNumber.text;
    VC.usCompanyCode = self.usCompanyCode;
}
- (void)dataCountTwoJudgment
{
    //本方
    if (!self.driverName.text.length) {
        [self infomationNoticeShowAlertViewMessage:@"车主姓名不能为空！！！"];
    }
    else if (!self.crNumber.text.length) {
        [self infomationNoticeShowAlertViewMessage:@"车主车辆车牌号不能为空！！！"];
    }
    else if (!companies) {
        [self infomationNoticeShowAlertViewMessage:@"车主车辆投保公司不能为空！！！"];
    }
    else if (!self.phoneNumber.text.length) {
        [self infomationNoticeShowAlertViewMessage:@"车主电话号码不能为空！！！"];
        
    }
    else if (!self.driverNumber.text.length) {
        [self infomationNoticeShowAlertViewMessage:@"车主驾驶证号不能为空！！！"];
    }
    
    //电话号码位数检测
    else if (self.phoneNumber.text.length != 11) {
        
        [self infomationNoticeShowAlertViewMessage:@"您的电话号码不是11位，请仔细检查！！！"];
    }
    
}
- (void)infomationNoticeShowAlertViewMessage:(NSString *)message
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    
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
