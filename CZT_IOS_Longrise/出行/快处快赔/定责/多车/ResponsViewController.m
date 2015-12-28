//
//  ResponsViewController.m
//  CZT_IOS_Longrise
//
//  Created by OSch on 15/12/3.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "ResponsViewController.h"
#import "Util.h"
#import "CZT_IOS_Longrise.pch"
#import "SureResponsController.h"
#import "InfimationModel.h"
#import "Globle.h"
#import "DutyViewController.h"
#import "FVCustomAlertView.h"

@interface ResponsViewController ()<CustomAlertViewDelegate>
{
    NSMutableString *descriType;
    
}

@property (strong, nonatomic) NSArray *ietms;
@property (strong, nonatomic) NSArray *titleName;

@end

@implementation ResponsViewController
- (NSArray *)ietms
{
    if (_ietms == nil) {
        _ietms = [NSArray array];
    }
    return _ietms;
}
- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
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
    
    
    [self setTableView];
    
    [self loadData];
    
    [self.controversy.layer setBorderWidth:1];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 61/255.0, 166/255.0, 265/255.0, 1 });
    [self.controversy.layer setBorderColor:colorref];
    
}
#pragma mark 当前时间
-(NSString *)currentDate
{
    NSDate *date = [NSDate date];
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
    NSString *currentDate = [dateformatter stringFromDate:date];
    return currentDate;
}
- (void)setTableView
{
    self.title = @"责任认定";
    self.view.backgroundColor = BackColor;
    self.responsTabView.backgroundColor = BackColor;
    self.responsTabView.delegate = self;
    self.responsTabView.dataSource = self;
    self.responsTabView.separatorStyle = UITableViewCellAccessoryNone;
    
    self.unControversy.backgroundColor = NavColor;
    self.ietms = [[NSBundle mainBundle]loadNibNamed:@"ResponsCell" owner:self options:nil];
    descriType = [[NSMutableString alloc]init];
    for (int i = 0; i < self.describeData.count; i++) {
        [descriType appendString:self.describeData[i]];
        [descriType appendString:@" "];
        
    }
    [self.allRespons setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
    [self.otherUnResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
    
    [self.unRespons setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
    [self.sameRespons setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
    [self.otherAllResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
    [self.otherSameResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
    [self.thirdAllResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
    [self.thirdUnResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
    [self.thirdSameResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    if (indexPath.row == 0) {
        static NSString *ID = @"ResponsCell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = BackColor;
        UIView *iodfi = self.ietms[indexPath.row];
        iodfi.frame = CGRectMake(self.responsTabView.frame.origin.x+10, 5, self.responsTabView.frame.size.width-20, 305);
        iodfi.layer.masksToBounds = YES;
        iodfi.layer.cornerRadius = 2;
        [cell addSubview:iodfi];
        return cell;
    }
    else if (indexPath.row == 1)
    {
        static NSString *ID = @"ResponsCell2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = BackColor;
        UIView *iodfi = self.ietms[indexPath.row];
        iodfi.frame = CGRectMake(self.responsTabView.frame.origin.x+10, 5, self.responsTabView.frame.size.width-20, 305);
        iodfi.layer.masksToBounds = YES;
        iodfi.layer.cornerRadius = 2;
        [cell addSubview:iodfi];
        return cell;
    }
    else
    {
        static NSString *ID = @"ResponsCell3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = BackColor;
        UIView *iodfi = self.ietms[indexPath.row];
        iodfi.frame = CGRectMake(self.responsTabView.frame.origin.x+10, 5, self.responsTabView.frame.size.width-20, 305);
        iodfi.layer.masksToBounds = YES;
        iodfi.layer.cornerRadius = 2;
        [cell addSubview:iodfi];
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 310;
}
- (void)loadData
{
    
    //本方
    self.name.text = self.usUserName;
    self.carNumber.text = self.usCarNumber;
    self.companyName.text = self.usCompanyName;
    self.phoneNumber.text = self.usPhoneNumber;
    self.driverNumber.text = self.usDriverNumber;
    //对方
    self.otherName.text = self.otherUserName;
    self.otherCarName.text = self.otherCarNumber;
    self.otherCompanyName.text = self.otherCompName;
    self.otherPhNumber.text = self.otherPhoneNumber;
    self.otherDriverNum.text = self.otherDriverNumber;
    //其他
    self.thirdNmae.text = self.thirdUserName;
    self.thirdCarName.text = self.thirdCarNumber;
    self.thirdCompanyName.text = self.thirdCompName;
    self.thirdPnoneNumber.text = self.thirdPhoneNum;
    self.thirdDriverNumber.text = self.thirdDriverNum;
    
}
//有争议
- (IBAction)turnControversy:(id)sender {
    
    
    [self upCaseInformation];
}
//无争议
- (IBAction)turnUnControversy:(id)sender {
    
    SureResponsController *sureResVC = [[SureResponsController alloc] init];
    sureResVC.hidesBottomBarWhenPushed = YES;
    sureResVC.dataSource = self.dataSource;
    [self unConversitionpassInfomation:sureResVC];
    [self.navigationController pushViewController:sureResVC animated:YES];
    
}
- (void)upCaseInformation
{
    FVCustomAlertView *fvalertView = [[FVCustomAlertView alloc]init];
    [fvalertView showAlertWithonView:self.view Width:100 height:100 contentView:nil cancelOnTouch:false Duration:0];
    NSMutableDictionary *usdict = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *otherdict = [[NSMutableDictionary alloc]init];
    NSMutableDictionary *thirddict = [[NSMutableDictionary alloc]init];
    
    NSString *imagelon = [NSString stringWithFormat:@"%f",[Globle getInstance].imagelon];
    NSString *imagelat = [NSString stringWithFormat:@"%f",[Globle getInstance].imagelat];
    
    
    NSMutableDictionary *bean2 = [[NSMutableDictionary alloc] init];
    [bean2 setValue:self.appcaseno forKey:@"appcaseno"];
    [bean2 setValue:self.usCarNumber forKey:@"casecarno"];
    [bean2 setValue:self.usPhoneNumber forKey:@"casetelephone"];
    [bean2 setValue:imagelon forKey:@"caselon"];
    [bean2 setValue:imagelat forKey:@"caselat"];
    [bean2 setValue:[Globle getInstance].imageaddress forKey:@"caseaddress"];
    [bean2 setValue:[self currentDate] forKey:@"casedate"];
    [bean2 setValue:descriType forKey:@"accidenttype"];
    [bean2 setValue:self.describeString forKey:@"accidentdes"];
    [bean2 setValue:[Globle getInstance].areaid forKey:@"areaid"];
    [bean2 setValue:[self carseData] forKey:@"casecarlist"];
    usdict = bean2[@"casecarlist"][0];
    otherdict = bean2[@"casecarlist"][1];
    if (self.dataSource.count == 3) {
        thirddict = bean2[@"casecarlist"][2];
    }
    
    [bean2 setValue:[Globle getInstance].loadDataName forKey:@"username"];
    [bean2 setValue:[Globle getInstance].loadDataPass forKey:@"password"];
    [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].serviceURL ServiceName:[NSString stringWithFormat:@"%@/zdsubmitcaseinfor",kckpzcslrest] params:bean2 httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        [fvalertView dismiss];
        NSLog(@"有争议  %@",result);
        NSLog(@"sheng  %@",result[@"redes"]);
        if (![result[@"redes"]isEqualToString:@"成功"]) {
        
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"上传案件信息失败！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            DutyViewController *DVC = [[DutyViewController alloc]init];
            DVC.usInfoDict = usdict;
            DVC.otherInfoDict = otherdict;
            DVC.thirdInfoDict = thirddict;
            [self conversitionPassInfomation:DVC];
            [self.navigationController pushViewController:DVC animated:YES];
            
            

        }
    } ];
    
}



#pragma mark casecarlist:    对象数组
- (NSMutableArray *)carseData
{
    
    //本方
    NSMutableDictionary *usCarListDict = [[NSMutableDictionary alloc]init];
    [usCarListDict setValue:self.usCarNumber forKey:@"casecarno"];
    [usCarListDict setValue:self.usCompanyName forKey:@"inscomname"];
    [usCarListDict setValue:self.usCompanyCode forKey:@"inscomcode"];
    [usCarListDict setValue:self.usUserName forKey:@"carownname"];
    [usCarListDict setValue:self.usPhoneNumber forKey:@"carownphone"];
    [usCarListDict setValue:self.usDriverNumber forKey:@"driverno"];

    
    //对方
    NSMutableDictionary *otherCarListDict = [[NSMutableDictionary alloc]init];
    [otherCarListDict setValue:self.otherCarNumber forKey:@"casecarno"];
    [otherCarListDict setValue:self.otherCompName forKey:@"inscomname"];
    [otherCarListDict setValue:self.otherCompanyCode forKey:@"inscomcode"];
    [otherCarListDict setValue:self.otherUserName forKey:@"carownname"];
    [otherCarListDict setValue:self.otherPhoneNumber forKey:@"carownphone"];
    [otherCarListDict setValue:self.otherDriverNumber forKey:@"driverno"];

    
    //其他
    NSMutableDictionary *thirdCarListDict = [[NSMutableDictionary alloc]init];
    [thirdCarListDict setValue:self.thirdCarNumber forKey:@"casecarno"];
    [thirdCarListDict setValue:self.thirdCompName forKey:@"inscomname"];
    [thirdCarListDict setValue:self.thirdCompanyCode forKey:@"inscomcode"];
    [thirdCarListDict setValue:self.thirdUserName forKey:@"carownname"];
    [thirdCarListDict setValue:self.thirdPhoneNum forKey:@"carownphone"];
    [thirdCarListDict setValue:self.thirdDriverNum forKey:@"driverno"];
    [thirdCarListDict setValue:self.appcaseno forKey:@"signimgurl"];
    [thirdCarListDict setValue:[self currentDate] forKey:@"signdate"];
    
    if (self.dataSource.count == 3) {
        NSMutableArray *casecarData = [NSMutableArray arrayWithObjects:usCarListDict,otherCarListDict,thirdCarListDict,nil];
        return casecarData;
    }else
    {
        NSMutableArray *casecarData = [NSMutableArray arrayWithObjects:usCarListDict,otherCarListDict,nil];
        return casecarData;
    }
    
}

#pragma mark - 责任认定
- (IBAction)allRespons:(id)sender {
    if (self.dataSource.count != 3) {
        self.usRespons = @"全责";
        self.otherRespons = @"无责";
        [self.allRespons setImage:[UIImage imageNamed:@"cellSelect_fill"] forState:UIControlStateNormal];
        [self.otherUnResponsBtn setImage:[UIImage imageNamed:@"cellSelect_fill"] forState:UIControlStateNormal];
        
        [self.unRespons setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.sameRespons setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.otherAllResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.otherSameResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.thirdAllResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.thirdUnResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.thirdSameResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
    }
    else
    {
       self.usRespons = @"全责";
        [self.allRespons setImage:[UIImage imageNamed:@"cellSelect_fill"] forState:UIControlStateNormal];
        [self.unRespons setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.sameRespons setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
    }
    
}
- (IBAction)unRespons:(id)sender {
    if (self.dataSource.count != 3) {
        self.usRespons = @"无责";
        self.otherRespons = @"全责";
        
        [self.unRespons setImage:[UIImage imageNamed:@"cellSelect_fill"] forState:UIControlStateNormal];
        [self.otherAllResponsBtn setImage:[UIImage imageNamed:@"cellSelect_fill"] forState:UIControlStateNormal];
        
        
        [self.allRespons setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.sameRespons setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.otherUnResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.otherSameResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.thirdAllResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.thirdUnResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.thirdSameResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
    }
    else
    {
        self.usRespons = @"无责";
        [self.allRespons setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.unRespons setImage:[UIImage imageNamed:@"cellSelect_fill"] forState:UIControlStateNormal];
        [self.sameRespons setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
    }
    
}
- (IBAction)sameRespons:(id)sender {
    
    if (self.dataSource.count != 3) {
        self.usRespons = @"同责";
        self.otherRespons = @"同责";
        [self.otherSameResponsBtn setImage:[UIImage imageNamed:@"cellSelect_fill"] forState:UIControlStateNormal];
        [self.sameRespons setImage:[UIImage imageNamed:@"cellSelect_fill"] forState:UIControlStateNormal];
        
        [self.allRespons setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.unRespons setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.otherUnResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.otherAllResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.thirdAllResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.thirdUnResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.thirdSameResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
    }
    else
    {
         self.usRespons = @"同责";
        [self.allRespons setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.unRespons setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.sameRespons setImage:[UIImage imageNamed:@"cellSelect_fill"] forState:UIControlStateNormal];
    }
   
}
//对方责任认定
- (IBAction)otherAllRespons:(id)sender {
    if (self.dataSource.count == 3) {
        self.otherRespons = @"全责";
        [self.otherUnResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.otherAllResponsBtn setImage:[UIImage imageNamed:@"cellSelect_fill"] forState:UIControlStateNormal];
        [self.otherSameResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
    }
    
}

- (IBAction)otherUnRespons:(id)sender {
    if (self.dataSource.count == 3) {
         self.otherRespons = @"无责";
        [self.otherUnResponsBtn setImage:[UIImage imageNamed:@"cellSelect_fill"] forState:UIControlStateNormal];
        [self.otherAllResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.otherSameResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
    }
   
}

- (IBAction)otherSameRespons:(id)sender {
    if (self.dataSource.count == 3) {
        self.otherRespons = @"同责";
        [self.otherUnResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.otherAllResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.otherSameResponsBtn setImage:[UIImage imageNamed:@"cellSelect_fill"] forState:UIControlStateNormal];
    }
   
}

//其他责任认定
- (IBAction)thirdAllRespons:(id)sender {
    if (self.dataSource.count == 3) {
         self.thirdRespons = @"全责";
        [self.thirdAllResponsBtn setImage:[UIImage imageNamed:@"cellSelect_fill"] forState:UIControlStateNormal];
        [self.thirdUnResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.thirdSameResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
    }
   
}

- (IBAction)thirdUnRespons:(id)sender {
    if (self.dataSource.count == 3) {
        self.thirdRespons = @"无责";
        [self.thirdAllResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.thirdUnResponsBtn setImage:[UIImage imageNamed:@"cellSelect_fill"] forState:UIControlStateNormal];
        [self.thirdSameResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
    }
   
}

- (IBAction)thirdSameRespons:(id)sender {
    if (self.dataSource.count == 3) {
        self.thirdRespons = @"同责";
        [self.thirdAllResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.thirdUnResponsBtn setImage:[UIImage imageNamed:@"cellUnSelect_fill"] forState:UIControlStateNormal];
        [self.thirdSameResponsBtn setImage:[UIImage imageNamed:@"cellSelect_fill"] forState:UIControlStateNormal];
    }
    
}

#pragma mark 无争议
-(void)unConversitionpassInfomation:(SureResponsController *)VC
{
    VC.dataSource = self.dataSource;
    VC.describeData = self.describeData;
    VC.appcaseno = self.appcaseno;
    VC.describeString = self.describeString;
    
    //本方
    VC.UserName = self.name.text;
    VC.CarNumber = self.carNumber.text;
    VC.CompanyName = self.companyName.text;
    VC.PhoneNumber = self.phoneNumber.text;
    VC.DriverNumber = self.driverNumber.text;
    VC.usSureRespons = self.usRespons;
    VC.usCompanyCode = self.usCompanyCode;
    
    //对方
    VC.otherUserName = self.otherName.text;
    VC.otherCarNumbers = self.otherCarName.text;
    VC.otherCompName = self.otherCompanyName.text;
    VC.otherPhoneNumbers = self.otherPhNumber.text;
    VC.otherDriNumber = self.otherDriverNum.text;
    VC.otherSureRespons = self.otherRespons;
    VC.otherCompanyCode = self.otherCompanyCode;
    
    //其他
    VC.thirdUserName = self.thirdNmae.text;
    VC.thirdCarNumbers = self.thirdCarName.text;
    VC.thirdCompName = self.thirdCompanyName.text;
    VC.thirdPhoneNum = self.thirdPnoneNumber.text;
    VC.thirdDriverNum = self.thirdDriverNumber.text;
    VC.thirdSureRespons = self.thirdRespons;
    VC.thirdCompanyCode = self.thirdCompanyCode;
}

#pragma mark 有争议

-(void)conversitionPassInfomation:(DutyViewController *)VC
{
    VC.dataSource = self.dataSource;
    VC.describeData = self.describeData;
    VC.appcaseno = self.appcaseno;
    VC.describeString = self.describeString;
    
    //本方
    VC.UserName = self.name.text;
    VC.CarNumber = self.carNumber.text;
    VC.CompanyName = self.companyName.text;
    VC.phoneNumber = self.phoneNumber.text;
    VC.DriverNumber = self.driverNumber.text;
    VC.usSureRespons = self.usRespons;
    VC.usCompanyCode = self.usCompanyCode;
    
    //对方
    VC.otherUserName = self.otherName.text;
    VC.otherCarNumbers = self.otherCarName.text;
    VC.otherCompName = self.otherCompanyName.text;
    VC.otherPhoneNumbers = self.otherPhNumber.text;
    VC.otherDriNumber = self.otherDriverNum.text;
    VC.otherSureRespons = self.otherRespons;
    VC.otherCompanyCode = self.otherCompanyCode;
    
    //其他
    VC.thirdUserName = self.thirdNmae.text;
    VC.thirdCarNumbers = self.thirdCarName.text;
    VC.thirdCompName = self.thirdCompanyName.text;
    VC.thirdPhoneNum = self.thirdPnoneNumber.text;
    VC.thirdDriverNum = self.thirdDriverNumber.text;
    VC.thirdSureRespons = self.thirdRespons;
    VC.thirdCompanyCode = self.thirdCompanyCode;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
