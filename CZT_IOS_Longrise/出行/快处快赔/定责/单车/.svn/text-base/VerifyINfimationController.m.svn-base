//
//  VerifyINfimationController.m
//  CZT_IOS_Longrise
//
//  Created by OSch on 15/12/11.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "VerifyINfimationController.h"
#import "CZT_IOS_Longrise.pch"
#import "FVCustomAlertView.h"

NSMutableDictionary *onlyCaseDict;

@interface VerifyINfimationController ()
{
    FVCustomAlertView *fvalertView;
}
@end

@implementation VerifyINfimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"核实当事人信息";
    
    [self loadVerifyData];
    
    self.showView.layer.masksToBounds = YES;
    self.showView.layer.cornerRadius = 2;
}
- (void)loadVerifyData
{
    self.driverNameLabel.text = self.usUserName;
    self.carNumberLabel.text = self.usCarNumber;
    self.companyNameLabel.text = self.usCompanyName;
    self.phoneNumberLabel.text = self.usPhoneNumber;
    self.driverNumberLabel.text = self.usDriverNumber;
    self.usCompanyCode = self.usCompanyCode;
    
    
}
- (IBAction)sureVerifyInfomation:(id)sender {
  
    [self upOnlyInfomation];
    
    //取证完成通知
    NSString *name = NotificationNameForOneStepFinish;
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:@"2" forKey:@"dealCaseStep"];
    [center postNotificationName:name object:nil userInfo:dic];
    
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
- (void)upOnlyInfomation
{
    fvalertView = [[FVCustomAlertView alloc]init];
    [fvalertView showAlertWithonView:self.view Width:100 height:100 contentView:nil cancelOnTouch:false Duration:0];
    
    NSString *imagelon = [NSString stringWithFormat:@"%f",[Globle getInstance].imagelon];
    NSString *imagelat = [NSString stringWithFormat:@"%f",[Globle getInstance].imagelat];
    NSString  *deviceID = [[NSUUID UUID] UUIDString];
    
    NSMutableDictionary *bean2 = [[NSMutableDictionary alloc] init];
    [bean2 setValue:self.appcaseno forKey:@"appcaseno"];
    [bean2 setValue:self.usCarNumber forKey:@"casecarno"];
    [bean2 setValue:self.usPhoneNumber forKey:@"casetelephoe"];
    [bean2 setValue:imagelon forKey:@"caselon"];
    [bean2 setValue:imagelat forKey:@"caselat"];
    [bean2 setValue:[Globle getInstance].imageaddress forKey:@"caseaddress"];
    [bean2 setValue:deviceID forKey:@"fastsingleno"];
    [bean2 setValue:[self currentDate] forKey:@"sibmitdate"];
    [bean2 setValue:[Globle getInstance].areaid forKey:@"areaid"];
    [bean2 setValue:[self carseData] forKey:@"casecarlist"];
    [bean2 setValue:[Globle getInstance].loadDataName forKey:@"username"];
    [bean2 setValue:[Globle getInstance].loadDataPass forKey:@"password"];
    [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].serviceURL ServiceName:[NSString stringWithFormat:@"%@/zdsubmitonlycaseinfo",kckpzcslrest] params:bean2 httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        NSLog(@"sheng  %@",result);
        NSLog(@"sheng  %@",result[@"redes"]);
        
        [fvalertView dismiss];
        
        if (![result[@"redes"]isEqualToString:@"成功"]) {
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"事故信息上传失败！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
            [self.navigationController popToViewController:[navigationArray objectAtIndex:1] animated:YES];
        }
    } ];
    
    [self reprotCaseData];
}
#pragma mark 保险报案数据
- (void)reprotCaseData
{
    onlyCaseDict = [[NSMutableDictionary alloc]init];
    NSString *imagelon = [NSString stringWithFormat:@"%f",[Globle getInstance].imagelon];
    NSString *imagelat = [NSString stringWithFormat:@"%f",[Globle getInstance].imagelat];
    
    [onlyCaseDict setValue:self.appcaseno forKey:@"appcaseno"];
    [onlyCaseDict setValue:self.usCarNumber forKey:@"casecarno"];
    [onlyCaseDict setValue:self.usPhoneNumber forKey:@"casetelephone"];
    [onlyCaseDict setValue:imagelon forKey:@"caselon"];
    [onlyCaseDict setValue:imagelat forKey:@"caselat"];
    [onlyCaseDict setValue:[Globle getInstance].imageaddress forKey:@"caseaddress"];
    [onlyCaseDict setValue:[self currentDate] forKey:@"casedate"];
    [onlyCaseDict setValue:self.usCompanyCode forKey:@"inscomcode"];
    [onlyCaseDict setValue:@"0" forKey:@"reportway"];
    [onlyCaseDict setValue:[Globle getInstance].areaid forKey:@"areaid"];
    [onlyCaseDict setValue:[self carseData] forKey:@"casecarlist"];
    [onlyCaseDict setValue:[Globle getInstance].loadDataName forKey:@"username"];
    [onlyCaseDict setValue:[Globle getInstance].loadDataPass forKey:@"password"];
    
    
}
#pragma mark casecarlist 对象数组
- (NSMutableArray *)carseData
{
    
    NSNumber *duty = [NSNumber numberWithInt:0];
    //本方
    NSMutableDictionary *usCarListDict = [[NSMutableDictionary alloc]init];
    [usCarListDict setValue:self.usCarNumber forKey:@"casecarno"];
    [usCarListDict setValue:duty forKey:@"dutytype"];
    [usCarListDict setValue:self.usCompanyName forKey:@"inscomname"];
    [usCarListDict setValue:self.usCompanyCode forKey:@"inscomcode"];
    [usCarListDict setValue:self.usUserName forKey:@"carownname"];
    [usCarListDict setValue:self.usPhoneNumber forKey:@"carownphone"];
    [usCarListDict setValue:self.usDriverNumber forKey:@"driverno"];
    NSMutableArray *arr = [NSMutableArray arrayWithObjects:usCarListDict, nil];
    return arr;
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
