//
//  FillInformationController.m
//  CZT_IOS_Longrise
//
//  Created by OSch on 15/12/3.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "FillInformationController.h"
#import <Masonry.h>
#import "Util.h"
#import "CZT_IOS_Longrise.pch"
#import "ResponsViewController.h"
#import "InfimationModel.h"
#import "UISelectListView.h"
#import "Globle.h"
#import "IQKeyboardManager.h"


@interface FillInformationController ()<UISelectListViewDelegate,UIAlertViewDelegate>
{
    UILabel *titlelabel;
    NSString *cities;
    NSString *companies;
    int carCitiesSelectIndex;
    int companySelectIndex;
    
}

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) NSMutableDictionary *recordValue;
@property (strong, nonatomic) NSArray *carCitiesData;
@property (strong, nonatomic) NSArray *titleName;
@property (strong, nonatomic) NSArray *ietms;
@end

@implementation FillInformationController
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}
- (NSArray *)carCitiesData
{
    if (_carCitiesData == nil) {
        _carCitiesData = [NSArray array];
    }
    return _carCitiesData;
}
- (NSArray *)ietms
{
    if (_ietms == nil) {
        _ietms = [NSArray array];
    }
    return _ietms;
}
- (NSArray *)titleName
{
    if (_titleName == nil) {
        _titleName = [NSArray array];
    }
    return _titleName;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"填写信息";
    self.view.backgroundColor = BackColor;
    
        //设置数据
    [self setData];

    
    [self setCompanyData];
    
    
    
    //toolbar的样式
    [self setKeyBoard];



}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}


- (void)setShowView
{
    self.thirdView.frame = CGRectMake(0, 0, 300, 345);
    self.backScrollView.contentSize = CGSizeMake(0, self.dataSource.count * 370);
    CGFloat pading = 20;
    NSArray *ietms = [[NSBundle mainBundle]loadNibNamed:@"Filecell" owner:self options:nil];
    for (int i = 0; i < 3; i++)
    {
        UIView *views = ietms[i];
        views.layer.masksToBounds = YES;
        views.layer.cornerRadius = 2;
        [self.backScrollView addSubview:views];
        [views mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(345);
            make.left.equalTo(self.backScrollView).with.offset(0);
            make.top.mas_equalTo((views.frame.origin.y + views.frame.size.height + pading)* i + pading);
            make.width.mas_equalTo(self.backScrollView.mas_width);
        }];
    }
    
}
- (void)setData
{

    
    self.deletCar.layer.borderColor=NavColor.CGColor;
    self.deletCar.layer.borderWidth = 1;
    self.deletCar.layer.masksToBounds = YES;
    
    self.titleName = @[@"本方驾驶人及车辆信息",@"对方驾驶人及车辆信息",@"其他驾驶人及车辆信息"];
    for (int i = 0; i < 2; i++) {
        [self.dataSource addObject:self.titleName[i]];
        
    }
    
    
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
}




#pragma mark - 查询公司名
-(void)setCompanyData
{

    //投保公司
    NSMutableDictionary *bean1 = [[NSMutableDictionary alloc] init];
    [bean1 setValue:[Globle getInstance].loadDataName forKey:@"username"];
    [bean1 setValue:[Globle getInstance].loadDataPass forKey:@"password"];
    [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].serviceURL ServiceName:[NSString stringWithFormat:@"%@/zdsearchallinscompanylist",kckpzcslrest] params:bean1 httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        [self setSeletViewCompanyData:result[@"data"]];
        
    } ];
    
   
}




#pragma mark - 设置button的样式
-(void)setKeyBoard
{
    self.deletCar.layer.borderColor=NavColor.CGColor;
    self.deletCar.layer.borderWidth = 1;
    self.deletCar.layer.masksToBounds = YES;
    
    self.nextStep.backgroundColor = NavColor;
    [self.deletCar setTitleColor:NavColor forState:UIControlStateNormal];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 61/255.0, 166/255.0, 265/255.0, 1 });
    [self.deletCar.layer setBorderColor:colorref];
    
    self.ietms = [[NSBundle mainBundle]loadNibNamed:@"Filecell" owner:self options:nil];
    
    
    
}


#pragma mark - 下一步
- (IBAction)nextstep:(id)sender {
    
    
    [self JudgmentInformation];

}

#pragma mark - 添加或者删除第三者车
- (IBAction)delegateCar:(id)sender {
    

    NSString *str = [self.deletCar titleLabel].text;
    
    if ([str isEqualToString:@"添加第三者车"])
    {
        [self.dataSource addObject:[self.titleName lastObject]];
        [self.deletCar setTitle:@"删除第三者车" forState:UIControlStateNormal];
        self.backScrollView.contentSize = CGSizeMake(0, self.dataSource.count * 370);
        self.hiddenThirdView.hidden = YES;
        
    }
    else if([str isEqualToString:@"删除第三者车"])
    {
        [self.dataSource removeObjectAtIndex:2];
        [self.deletCar setTitle:@"添加第三者车" forState:UIControlStateNormal];
        self.backScrollView.contentSize = CGSizeMake(0, self.dataSource.count * 370);
        self.hiddenThirdView.hidden = NO;
        
    }
    
    
}


#pragma mark - selectList Delegate
-(void)selectListView:(UISelectListView *)selectListView index:(NSUInteger)index content:(NSDictionary *)dic
{
    if (selectListView == carSelectCities) {
        cities = dic[@"cities"];
    }
    else if (selectListView == usSelectCompany)
    {
        companies = dic[@"inscomname"];
        self.usCompanyCode = dic[@"inscomcode"];
        
    }
    else if (selectListView == otherCarSelectCities)
    {
        cities = dic[@"cities"];
    }
    else if (selectListView == otherSelectCompany)
    {
        companies = dic[@"inscomname"];
        self.otherCompanyCode = dic[@"inscomcode"];
    }
    else if (selectListView == thirdCarSelectCities)
    {
        cities = dic[@"cities"];
    }
    else if (selectListView == thirdSelectCompany)
    {
        companies = dic[@"inscomname"];
        self.thirdCompanyCode = dic[@"inscomcode"];
    }
    
}


#pragma mark - 添加下拉选择菜单
-(void)setSeletViewCompanyData:(NSArray *)array
{
    //加载显示的View
    [self setShowView];
    
    NSString *cityStr = [self.reciveCarNumber substringToIndex:1];
    NSString *numberStr = [self.reciveCarNumber substringFromIndex:1];
    NSDictionary *dict = [[NSDictionary alloc]init];
    for (int  i = 0; i < self.carCitiesData.count; i++) {
        dict = self.carCitiesData[i];
        NSLog(@"dict = %@",dict);
        if ([cityStr isEqualToString:dict[@"cities"]]) {
            carCitiesSelectIndex = i;
        }
    }
    
    if (self.reciveCarNumber) {
        self.carNumber.text = numberStr;
    }
    
    CGFloat top = 8;
    CGFloat left = 5;
    CGFloat bottom = 8;
    CGFloat right = 5;
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    UIImage *backLine = [[UIImage imageNamed:@"select_line"] resizableImageWithCapInsets:insets];
    self.name.background = backLine;
    self.carBackViewLine.image = backLine;
    self.usPHBackLine.image = backLine;
    self.driverNumber.background = backLine;
    
    
    self.otherPartyName.background = backLine;
    self.otherCarBackViewLine.image = backLine;
    self.otherPartyPhoneNumber.background = backLine;
    self.otherPartyDriverNumber.background = backLine;
    
    self.thirdPartyName.background = backLine;
    self.thirdCarBackViewLine.image = backLine;
    self.thirdPartyPhoneNumber.background = backLine;
    self.thirdPartyDriverNumber.background = backLine;

    
    NSDictionary *userinfo = [[Globle getInstance].loginInfoDic objectForKey:@"userinfo"];
    self.phoneNumber.text = userinfo[@"mobilephone"];
    
    //本方 车牌号
    self.carView.userInteractionEnabled = YES;
    carSelectCities  = [[UISelectListView alloc]initWithFrame:self.carView.bounds];
    carSelectCities.currentView = self.view;
    carSelectCities.delegate = self;
    
    [carSelectCities addArray:self.carCitiesData forKey:@"cities"];
    
    if (self.reciveCarNumber) {
       [carSelectCities setSelectIndex:carCitiesSelectIndex];
    }
    
    carSelectCities.backgroundColor = [UIColor whiteColor];
    [carSelectCities setIcon:[UIImage imageNamed:@"select_input"]];
    [carSelectCities setDropWidth:50];
    [self.carView addSubview:carSelectCities];
    
    usSelectCompany = [[UISelectListView alloc]initWithFrame:CGRectMake(0, 0,self.backScrollView.frame.size.width-125, self.companyView.bounds.size.height)];
    usSelectCompany.currentView = self.view;
    usSelectCompany.delegate = self;
    usSelectCompany.titleLabel.font = [UIFont systemFontOfSize:13];
    [usSelectCompany addArray:array forKey:@"inscomname"];
    usSelectCompany.backgroundColor = [UIColor whiteColor];
    [usSelectCompany setBackgroundImage:backLine forState:UIControlStateNormal];
    [usSelectCompany setIcon:[UIImage imageNamed:@"select_input"]];
    [usSelectCompany setDropWidth:50];
    [self.companyView addSubview:usSelectCompany];
    
    
    //对方 车牌号
    otherCarSelectCities = [[UISelectListView alloc]initWithFrame:self.otherCarView.bounds];
    otherCarSelectCities.currentView = self.view;
    otherCarSelectCities.delegate = self;
    [otherCarSelectCities addArray:self.carCitiesData forKey:@"cities"];
    otherCarSelectCities.backgroundColor = [UIColor whiteColor];
    [otherCarSelectCities setIcon:[UIImage imageNamed:@"select_input"]];
    [otherCarSelectCities setDropWidth:50];
    [self.otherCarView addSubview:otherCarSelectCities];
    
    otherSelectCompany = [[UISelectListView alloc]initWithFrame:CGRectMake(0, 0, self.backScrollView.frame.size.width-125, self.otherPartyCompanyView.frame.size.height)];
    otherSelectCompany.currentView = self.view;
    otherSelectCompany.delegate = self;
    [otherSelectCompany addArray:array forKey:@"inscomname"];
    otherSelectCompany.backgroundColor = [UIColor whiteColor];
    [otherSelectCompany setBackgroundImage:backLine forState:UIControlStateNormal];
    [otherSelectCompany setIcon:[UIImage imageNamed:@"select_input"]];
    [otherSelectCompany setDropWidth:50];
    [self.otherPartyCompanyView addSubview:otherSelectCompany];
    
    //其他 车牌号
    thirdCarSelectCities = [[UISelectListView alloc]initWithFrame:self.thirdCarView.bounds];
    thirdCarSelectCities.currentView = self.view;
    thirdCarSelectCities.delegate = self;
    [thirdCarSelectCities addArray:self.carCitiesData forKey:@"cities"];
    thirdCarSelectCities.backgroundColor = [UIColor whiteColor];
    [thirdCarSelectCities setIcon:[UIImage imageNamed:@"select_input"]];
    [thirdCarSelectCities setDropWidth:50];
    [self.thirdCarView addSubview:thirdCarSelectCities];
    
    thirdSelectCompany = [[UISelectListView alloc]initWithFrame:CGRectMake(0, 0, self.backScrollView.frame.size.width-125, self.thirdPartyCompanyView.bounds.size.height)];
    thirdSelectCompany.currentView = self.view;
    thirdSelectCompany.delegate = self;
    [thirdSelectCompany addArray:array forKey:@"inscomname"];
    thirdSelectCompany.backgroundColor = [UIColor whiteColor];
    [thirdSelectCompany setBackgroundImage:backLine forState:UIControlStateNormal];
    [thirdSelectCompany setIcon:[UIImage imageNamed:@"select_input"]];
    [thirdSelectCompany setDropWidth:50];
    [self.thirdPartyCompanyView addSubview:thirdSelectCompany];
    

    
}





#pragma mark - 跳转下一步
- (void)JudgmentInformation
{
    
    if (self.dataSource.count == 3) {
        
        if (!self.name.text.length || !self.carNumber.text.length || !cities || !companies || !self.phoneNumber.text.length || !self.driverNumber.text.length || !self.otherPartyName.text.length || !self.otherCarNumber.text.length || !self.otherPartyPhoneNumber.text.length || !self.otherPartyDriverNumber.text.length || !self.thirdPartyName.text.length || !self.thirdCarNumber.text.length || !self.thirdPartyPhoneNumber.text.length || !self.thirdPartyDriverNumber.text.length)
        {
            [self dataCountTwoJudgment];
            [self dataCountThirdJudgment];
            
        }
        else
        {
            if (self.phoneNumber.text.length && self.otherPartyPhoneNumber.text.length && self.thirdPartyPhoneNumber.text.length)
            {
                [self judgmentPhoneNumberCount];
            }
            
            self.nextStep.enabled = YES;
            ResponsViewController *responsVC = [[ResponsViewController alloc]init];
            responsVC.hidesBottomBarWhenPushed = YES;
            [self passInfomation:responsVC];
            [self.navigationController pushViewController:responsVC animated:YES];
            
        }
    }
    else
    {
        if (!self.name.text.length || !self.carNumber.text.length || !cities || !companies || !self.phoneNumber.text.length || !self.driverNumber.text.length || !self.otherPartyName.text.length || !self.otherCarNumber.text.length || !self.otherPartyPhoneNumber.text.length || !self.otherPartyDriverNumber.text.length )
        {
            [self dataCountTwoJudgment];
            
        }
        else
        {
            if (self.phoneNumber.text.length && self.otherPartyPhoneNumber.text.length)
            {
                [self judgmentPhoneNumberCount];
            }
            
            self.nextStep.enabled = YES;
            ResponsViewController *responsVC = [[ResponsViewController alloc]init];
            responsVC.hidesBottomBarWhenPushed = YES;
            [self passInfomation:responsVC];
            [self.navigationController pushViewController:responsVC animated:YES];
            
        }
    }
   

   
    
}

-(void)passInfomation:(ResponsViewController *)VC
{
    VC.dataSource = self.dataSource;
    VC.describeData = self.describeData;
    VC.appcaseno = self.appcaseno;
    VC.describeString = self.describeString;
    NSLog(@"respons = %@",self.appcaseno);
    
    //本方
    
    VC.usUserName = self.name.text;
    VC.usCarNumber = [NSString stringWithFormat:@"%@%@",cities,self.carNumber.text];
    VC.usCompanyName = companies;
    VC.usCompanyCode = self.usCompanyCode;
    VC.usPhoneNumber = self.phoneNumber.text;
    VC.usDriverNumber = self.driverNumber.text;
    
    //对方
    
    VC.otherUserName = self.otherPartyName.text;
    VC.otherCarNumber = [NSString stringWithFormat:@"%@%@",cities,self.otherCarNumber.text];
    VC.otherCompName = companies;
    VC.otherCompanyCode = self.otherCompanyCode;
    VC.otherPhoneNumber = self.otherPartyPhoneNumber.text;
    VC.otherDriverNumber = self.otherPartyDriverNumber.text;
    
    //其他
    
    VC.thirdUserName = self.thirdPartyName.text;
    VC.thirdCarNumber = [NSString stringWithFormat:@"%@%@",cities,self.thirdCarNumber.text];
    VC.thirdCompName = companies;
    VC.thirdCompanyCode = self.thirdCompanyCode;
    VC.thirdPhoneNum = self.thirdPartyPhoneNumber.text;
    VC.thirdDriverNum = self.thirdPartyDriverNumber.text;
    
}

#pragma mark - 判断
- (void)dataCountTwoJudgment
{
    //本方
    if (!self.name.text.length) {
        [self infomationNoticeShowAlertViewMessage:@"车主姓名不能为空！！！"];
    }
    else if (!self.carNumber.text.length) {
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
    
    //对方
    else if (!self.otherPartyName.text.length) {
        [self infomationNoticeShowAlertViewMessage:@"对方车主姓名不能为空！！！"];
    }
    else if (!self.otherCarNumber.text.length) {
        [self infomationNoticeShowAlertViewMessage:@"对方车主车辆车牌号不能为空！！！"];
    }
    else if (!companies) {
        [self infomationNoticeShowAlertViewMessage:@"对方车主车辆投保公司不能为空！！"];
    }
    else if (!self.otherPartyPhoneNumber.text.length) {
        [self infomationNoticeShowAlertViewMessage:@"对方车主电话号码不能为空！！！"];
        
    }
    else if (!self.otherPartyDriverNumber.text.length) {
        [self infomationNoticeShowAlertViewMessage:@"对方车主驾驶证号不能为空！！！！"];
    }
  
}
- (void)dataCountThirdJudgment
{
    //第三方
    if (!self.thirdPartyName.text.length) {
        [self infomationNoticeShowAlertViewMessage:@"第三方车主姓名不能为空！！！"];
    }
    else if (!self.thirdCarNumber.text.length) {
        [self infomationNoticeShowAlertViewMessage:@"第三方车主车辆车牌号不能为空！！！"];
    }
    else if (!companies) {
        [self infomationNoticeShowAlertViewMessage:@"第三方车主电话号码不能为空！！！"];
    }
    else if (!self.thirdPartyPhoneNumber.text.length) {
        [self infomationNoticeShowAlertViewMessage:@"第三方车主电话号码不能为空！！！"];
    }
    else if (!self.thirdPartyDriverNumber.text.length) {
        [self infomationNoticeShowAlertViewMessage:@"第三方车主驾驶证号不能为空！！！"];
    }
   
}

- (void)infomationNoticeShowAlertViewMessage:(NSString *)message
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    
}
#pragma mark - 判断电话号码是否是11位
- (void)judgmentPhoneNumberCount
{
    if (self.dataSource.count == 2)
    {
        if (self.otherPartyPhoneNumber.text.length != 11)
        {
            [self infomationNoticeShowAlertViewMessage:@"对方车主的电话号码不是11位，请仔细检查！！！"];
        }
        else if (self.phoneNumber.text.length != 11)
        {
            [self infomationNoticeShowAlertViewMessage:@"您的电话号码不是11位，请仔细检查！！！"];
        }
    }
    else
    {
        if (self.otherPartyPhoneNumber.text.length != 11)
        {
            [self infomationNoticeShowAlertViewMessage:@"对方车主的电话号码不是11位，请仔细检查！！！"];
        }
        else if (self.phoneNumber.text.length != 11)
        {
            [self infomationNoticeShowAlertViewMessage:@"您的电话号码不是11位，请仔细检查！！！"];
        }
        else if (self.thirdPartyPhoneNumber.text.length != 11)
        {
            [self infomationNoticeShowAlertViewMessage:@"第三方车主的电话号码不是11位，请仔细检查！！！"];
        }
    }
    
    
    
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
