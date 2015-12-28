//
//  SureResponsController.m
//  CZT_IOS_Longrise
//
//  Created by OSch on 15/12/3.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "SureResponsController.h"
#import "Util.h"
#import "CZT_IOS_Longrise.pch"
#import <Masonry.h>
#import "ARAViewController.h"
#import "SignViewController.h"
#import "PJRSignatureView.h"
#import "Globle.h"
#import <QuartzCore/QuartzCore.h>
#import <QuartzCore/CoreAnimation.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import "InfimationModel.h"
#import "FVCustomAlertView.h"
#import "FVCustomAlertView.h"

NSMutableDictionary *caseDict;
NSNumber *caseDutyType;

@interface SureResponsController ()<UIAlertViewDelegate,CustomAlertViewDelegate>
{
    NSInteger choseCount ;
    NSString *deviceID;//UUID
    int descriType;
    NSMutableArray *dictArray;
    int usDutyType; //责任类型
    int otherDutyType; //责任类型
    int thirdDutyType; //责任类型
    FVCustomAlertView *fvalertView;
}
@property (strong, nonatomic) UIImage *usSignName;
@property (strong, nonatomic) UIImage *otherSignName;
@property (strong, nonatomic) UIImage *thirdSignName;
@property (strong, nonatomic) NSString *usSignUrl;
@property (strong, nonatomic) NSString *otherSignUrl;
@property (strong, nonatomic) NSString *thirdSignUrl;
@property (strong, nonatomic) NSString *ARVWebString;
@property (strong, nonatomic) NSArray *ietms;

@end

@implementation SureResponsController
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

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置tabbleView
    [self setTableView];
    
    
    //加载显示数据
    [self loadData];
    
    //设置需要传递的参数
    [self saveInfomations];
   
    //设置发送验证码的button
    [self setVerificationButton];
}

#pragma mark - tabbleViewDelegate
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
    
    static NSString *ID = @"SureResponsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = BackColor;
    if (indexPath.row == 0) {
        
        UIView *iodfi = self.ietms[indexPath.row];
        iodfi.frame = CGRectMake(self.sureTabView.frame.origin.x+10, 5, self.sureTabView.frame.size.width-20, 305);
        iodfi.layer.masksToBounds = YES;
        iodfi.layer.cornerRadius = 2;
        [cell addSubview:iodfi];
        return cell;
    }
    else if(indexPath.row == 1)
    {
        
        UIView *iodfi = self.ietms[indexPath.row];;
        iodfi.frame = CGRectMake(self.sureTabView.frame.origin.x+10, 5, self.sureTabView.frame.size.width-20, 350);
        iodfi.layer.masksToBounds = YES;
        iodfi.layer.cornerRadius = 2;
        [cell addSubview:iodfi];
        return cell;
    }
    else
    {
        UIView *iodfi = self.ietms[indexPath.row];;
        iodfi.frame = CGRectMake(self.sureTabView.frame.origin.x+10, 5, self.sureTabView.frame.size.width-20, 350);
        iodfi.layer.masksToBounds = YES;
        iodfi.layer.cornerRadius = 2;
        [cell addSubview:iodfi];
        return cell;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 310;
    }
    return 360;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 70;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    
    return [self footSighButton];
    
}


#pragma mark 发送验证码
- (void)otherSendVification:(UIButton *)btn {
    

    [self startLoadData:btn];

    
}



-(void)startLoadData:(UIButton *)btn
{
    NSMutableDictionary *bean = [[NSMutableDictionary alloc] init];
    if (btn == otherCode) {
        [bean setValue:self.otherPhoneNumbers forKey:@"phonenumber"];
    }else if (btn == thirdCode)
    {
        [bean setValue:self.thirdPhoneNum forKey:@"phonenumber"];
    }
    
    [bean setValue:[Globle getInstance].loadDataName forKey:@"username"];
    [bean setValue:[Globle getInstance].loadDataPass forKey:@"password"];
    [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].serviceURL ServiceName:[NSString stringWithFormat:@"%@/kckpAppSendVercode",kckpzcslrest] params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        if (![result[@"redes"]isEqualToString:@"获取验证码成功!"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"验证码发送失败，请重新发送" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [otherCode stop];
            [thirdCode stop];
        }
        
    } ];
    
    
}


#pragma mark 签名信息
-(void)passSignImage:(UIImage *)signImage
{
    if (choseCount == 0) {
        self.selfbtn.backgroundColor = [UIColor clearColor];
        [self.selfbtn setTitle:@"" forState:UIControlStateNormal];
        [self.selfbtn setBackgroundImage:signImage forState:UIControlStateNormal];
        self.usSignName = signImage;
        [self vificationSign:signImage Type:choseCount];
    }
    else if(choseCount ==1 )
    {
        self.otherbtn.backgroundColor = [UIColor clearColor];
        [self.otherbtn setTitle:@"" forState:UIControlStateNormal];
        [self.otherbtn setBackgroundImage:signImage forState:UIControlStateNormal];
        self.otherSignName = signImage;
        [self vificationSign:signImage Type:choseCount];
    }
    else if (choseCount == 2)
    {
        self.thirdbtn.backgroundColor = [UIColor clearColor];
        [self.thirdbtn setTitle:@"" forState:UIControlStateNormal];
        [self.thirdbtn setBackgroundImage:signImage forState:UIControlStateNormal];
        self.thirdSignName = signImage;
        [self vificationSign:signImage Type:choseCount];
    }
    

    
}
- (void)vificationSign:(UIImage *)usSignImage Type:(NSInteger)typeCount
{
    NSData *_data = UIImageJPEGRepresentation(usSignImage, 0.9);
    NSString * encodedImageStr = [_data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    encodedImageStr = [encodedImageStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符
    encodedImageStr = [encodedImageStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    encodedImageStr = [encodedImageStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    encodedImageStr = [encodedImageStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    encodedImageStr = [NSString stringWithFormat:@"\"%@\"",encodedImageStr];
    NSNumber *type = [NSNumber numberWithInt:1];
    NSMutableDictionary *bean = [[NSMutableDictionary alloc] init];
    [bean setValue:encodedImageStr forKey:@"filedata"];
    [bean setValue:type forKey:@"filetype"];
    [bean setValue:[Globle getInstance].loadDataName forKey:@"username"];
    [bean setValue:[Globle getInstance].loadDataPass forKey:@"password"];
    [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].serviceURL ServiceName:[NSString stringWithFormat:@"%@/kckpAppUploadFile",kckpzcslrest] params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        if (typeCount == 0) {
          self.usSignUrl = result[@"data"][@"fileurl"];
        }
        else if (typeCount == 1)
        {
            self.otherSignUrl = result[@"data"][@"fileurl"];
        }
        else if (typeCount == 2)
        {
            self.thirdSignUrl = result[@"data"][@"fileurl"];
        }
        
    } ];
}



#pragma mark 本人签名
-(void)selfbtnClick
{
    choseCount = 0;
    SignViewController *signVC = [[SignViewController alloc]init];
    signVC.delegate = self;
    [self presentViewController:signVC animated:YES completion:nil];
    
}
#pragma mark 对方签名
-(void)otherbtnClick
{
    choseCount = 1;
    SignViewController *signVC = [[SignViewController alloc]init];
    signVC.delegate = self;
    [self presentViewController:signVC animated:YES completion:nil];
}

#pragma mark 第三方签名
-(void)thirdbtnClick
{
    choseCount = 2;
    SignViewController *signVC = [[SignViewController alloc]init];
    signVC.delegate = self;
    [self presentViewController:signVC animated:YES completion:nil];
}
#pragma mark 确认事故 生成协议书
- (IBAction)generateAgreement:(id)sender {
    

    [self upAgreementInformation];

}

#pragma mark 生成事故协议书

- (void)upAgreementInformation
{
    
    if (!self.otherVerificationCode.text.length) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"验证码验证不能为空！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    }
    else
    {
        NSMutableDictionary *bean = [[NSMutableDictionary alloc] init];
        [bean setValue:self.otherPhoneNumbers forKey:@"phonenumber"];
        [bean setValue:self.otherVerificationCode.text forKey:@"validatecode"];
        
        NSMutableDictionary *bean1 = [[NSMutableDictionary alloc] init];
        [bean1 setValue:bean forKey:@"userbean"];
        [bean1 setValue:[Globle getInstance].loadDataName forKey:@"username"];
        [bean1 setValue:[Globle getInstance].loadDataPass forKey:@"password"];
        [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].serviceURL ServiceName:[NSString stringWithFormat:@"%@/kckpAppValCode",kckpzcslrest] params:bean1 httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
            
            
            if (![result[@"redes"]isEqualToString:@"通过"]) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"验证码验证失败，请重新发送" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
            
        } ];
        
        [self upCaseInformation];
    }

    
    
}
- (void)upCaseInformation
{
    fvalertView = [[FVCustomAlertView alloc]init];
    [fvalertView showAlertWithonView:self.view Width:100 height:100 contentView:nil cancelOnTouch:false Duration:0];
    
    NSString *imagelon = [NSString stringWithFormat:@"%f",[Globle getInstance].imagelon];
    NSString *imagelat = [NSString stringWithFormat:@"%f",[Globle getInstance].imagelat];
    NSNumber *desDuty = [NSNumber numberWithInt:descriType];
    
    NSMutableDictionary *bean2 = [[NSMutableDictionary alloc] init];
    [bean2 setValue:self.appcaseno forKey:@"appcaseno"];
    [bean2 setValue:self.CarNumber forKey:@"casecarno"];
    [bean2 setValue:self.PhoneNumber forKey:@"casetelephoe"];
    [bean2 setValue:imagelon forKey:@"caselon"];
    [bean2 setValue:imagelat forKey:@"caselat"];
    [bean2 setValue:[Globle getInstance].imageaddress forKey:@"caseaddress"];
    [bean2 setValue:deviceID forKey:@"fastsingleno"];
    [bean2 setValue:[self currentDate] forKey:@"sibmitdate"];
    [bean2 setValue:desDuty forKey:@"accidenttype"];
    [bean2 setValue:self.describeString forKey:@"accidentdes"];
    [bean2 setValue:[Globle getInstance].areaid forKey:@"areaid"];
    [bean2 setValue:[self carseData] forKey:@"casecarlist"];
    [bean2 setValue:[Globle getInstance].loadDataName forKey:@"username"];
    [bean2 setValue:[Globle getInstance].loadDataPass forKey:@"password"];
    [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].serviceURL ServiceName:[NSString stringWithFormat:@"%@/zdsubmitcasefastsingle",kckpzcslrest] params:bean2 httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        NSLog(@"sheng  %@",result);
        NSLog(@"sheng  %@",result[@"redes"]);
        
        [fvalertView dismiss];
        
        if (![result[@"redes"]isEqualToString:@"成功"]) {

            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"生成事故协议书失败！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"ARAView" bundle:nil];
            ARAViewController *araVC = [storyboard instantiateViewControllerWithIdentifier:@"AraRespons"];
            araVC.hidesBottomBarWhenPushed = YES;
            araVC.ARVWebString = result[@"data"][@"url"];
            [self.navigationController pushViewController:araVC animated:YES];
        }
    } ];
    
    //保险报案数据
    [self reprotCaseData];
}

#pragma mark 保险报案数据
- (void)reprotCaseData
{
    caseDict = [[NSMutableDictionary alloc]init];
    NSString *imagelon = [NSString stringWithFormat:@"%f",[Globle getInstance].imagelon];
    NSString *imagelat = [NSString stringWithFormat:@"%f",[Globle getInstance].imagelat];
    
    [caseDict setValue:self.appcaseno forKey:@"appcaseno"];
    [caseDict setValue:self.CarNumber forKey:@"casecarno"];
    [caseDict setValue:self.otherPhoneNumbers forKey:@"casetelephone"];
    [caseDict setValue:imagelon forKey:@"caselon"];
    [caseDict setValue:imagelat forKey:@"caselat"];
    [caseDict setValue:[Globle getInstance].imageaddress forKey:@"caseaddress"];
    [caseDict setValue:[self currentDate] forKey:@"casedate"];
    [caseDict setValue:self.usCompanyCode forKey:@"inscomcode"];
    [caseDict setValue:@"0" forKey:@"reportway"];
    [caseDict setValue:[Globle getInstance].areaid forKey:@"areaid"];
    [caseDict setValue:[self carseData] forKey:@"casecarlist"];
    [caseDict setValue:[Globle getInstance].loadDataName forKey:@"username"];
    [caseDict setValue:[Globle getInstance].loadDataPass forKey:@"password"];
    
}
#pragma mark casecarlist:    对象数组
- (NSMutableArray *)carseData
{
    
    NSNumber *usduty = [NSNumber numberWithInt:usDutyType];
    NSNumber *otherduty = [NSNumber numberWithInt:otherDutyType];
    NSNumber *thirdduty = [NSNumber numberWithInt:thirdDutyType];
    
    caseDutyType = usduty;
    //本方
    NSMutableDictionary *usCarListDict = [[NSMutableDictionary alloc]init];
    [usCarListDict setValue:self.CarNumber forKey:@"casecarno"];
    [usCarListDict setValue:usduty forKey:@"dutytype"];
    [usCarListDict setValue:self.CompanyName forKey:@"inscomname"];
    [usCarListDict setValue:self.usCompanyCode forKey:@"inscomcode"];
    [usCarListDict setValue:self.UserName forKey:@"carownname"];
    [usCarListDict setValue:self.PhoneNumber forKey:@"carownphone"];
    [usCarListDict setValue:self.DriverNumber forKey:@"driverno"];
    [usCarListDict setValue:self.usSignUrl forKey:@"signimgurl"];
    [usCarListDict setValue:[self currentDate] forKey:@"signdate"];
    
    //对方
    NSMutableDictionary *otherCarListDict = [[NSMutableDictionary alloc]init];
    [otherCarListDict setValue:self.otherCarNumbers forKey:@"casecarno"];
    [otherCarListDict setValue:otherduty forKey:@"dutytype"];
    [otherCarListDict setValue:self.otherCompName forKey:@"inscomname"];
    [otherCarListDict setValue:self.otherCompanyCode forKey:@"inscomcode"];
    [otherCarListDict setValue:self.otherUserName forKey:@"carownname"];
    [otherCarListDict setValue:self.otherPhoneNumbers forKey:@"carownphone"];
    [otherCarListDict setValue:self.otherDriNumber forKey:@"driverno"];
    [otherCarListDict setValue:self.otherSignUrl forKey:@"signimgurl"];
    [otherCarListDict setValue:[self currentDate] forKey:@"signdate"];
    
    //其他
    NSMutableDictionary *thirdCarListDict = [[NSMutableDictionary alloc]init];
    [thirdCarListDict setValue:self.thirdCarNumbers forKey:@"casecarno"];
    [thirdCarListDict setValue:thirdduty forKey:@"dutytype"];
    [thirdCarListDict setValue:self.thirdCompName forKey:@"inscomname"];
    [thirdCarListDict setValue:self.thirdCompanyCode forKey:@"inscomcode"];
    [thirdCarListDict setValue:self.thirdUserName forKey:@"carownname"];
    [thirdCarListDict setValue:self.thirdPhoneNum forKey:@"carownphone"];
    [thirdCarListDict setValue:self.thirdDriverNum forKey:@"driverno"];
    [thirdCarListDict setValue:self.thirdSignUrl forKey:@"signimgurl"];
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

-(void)loadData
{

    //本方
    self.usName.text = self.UserName;
    self.usCarNumber.text = self.CarNumber;
    self.usCompany.text = self.CompanyName;
    self.usPhoneNumber.text = self.PhoneNumber;
    self.usDirverNumber.text = self.DriverNumber;
    self.usRespons.text = self.usSureRespons;
    //对方
    self.otherName.text = self.otherUserName;
    self.otherCarNumber.text = self.otherCarNumbers;
    self.otherCompany.text = self.otherCompName;
    self.otherPhoneNumber.text = self.otherPhoneNumbers;
    self.otherDirverNumber.text = self.otherDriNumber;
    self.otherRespons.text = self.otherSureRespons;
    //其他
    self.thirdName.text = self.thirdUserName;
    self.thirdCarNumber.text = self.thirdCarNumbers;
    self.thirdCompany.text = self.thirdCompName;
    self.thirdPhoneNumber.text = self.thirdPhoneNum;
    self.thirdDirverNumber.text = self.thirdDriverNum;
    self.thirdRespons.text = self.thirdSureRespons;
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
- (void)saveInfomations
{
    deviceID = [[NSUUID UUID] UUIDString];
    descriType = [self accidenttype:self.describeData[0]];
    
    usDutyType = [self dutyType:self.usSureRespons];
    otherDutyType = [self dutyType:self.otherSureRespons];
    thirdDutyType = [self dutyType:self.thirdSureRespons];
    
    
    
}
- (int)dutyType:(NSString *)respons
{
    int type;
    if ([respons isEqualToString:@"全责"]) {
        type = 0;
    }
    else if ([respons isEqualToString:@"无责"])
    {
        type = 1;
    }
    else
    {
        type = 2;
    }
    return type;
}

- (int )accidenttype:(NSString *)respons
{
    int type;
    if ([respons isEqualToString:@"追尾的"]) {
        type =0;
    }
    else if ([respons isEqualToString:@"逆行的"])
    {
        type = 1;
    }
    else if ([respons isEqualToString:@"倒车的"])
    {
        type = 2;
    }
    else if ([respons isEqualToString:@"溜车的"])
    {
        type = 3;
    }
    else if ([respons isEqualToString:@"开车门的"])
    {
        type = 4;
    }
    else if ([respons isEqualToString:@"违反交通信号的"])
    {
        type = 5;
    }
    else if ([respons isEqualToString:@"未按规定让行的"])
    {
        type = 6;
    }
    else if ([respons isEqualToString:@"并线的"])
    {
        type = 7;
    }
    else if ([respons isEqualToString:@"全部责任的其他情形"])
    {
        type = 8;
    }
    return type;
}

- (void)setTableView
{
    choseCount = -1;
    
    
    self.title = @"责任认定";
    self.view.backgroundColor = BackColor;
    self.sureTabView.backgroundColor = BackColor;
    self.sureTabView.delegate = self;
    self.sureTabView.dataSource = self;
    self.sureTabView.separatorStyle = UITableViewCellAccessoryNone;
    self.ietms = [[NSBundle mainBundle]loadNibNamed:@"SureResponsCell" owner:self options:nil];
    
    //确定按钮的样式
    self.sureResponsBtn.layer.borderColor=NavColor.CGColor;
    self.sureResponsBtn.layer.borderWidth = 1;
    self.sureResponsBtn.layer.masksToBounds = YES;
    
    //背景线
    CGFloat top = 8;
    CGFloat left = 5;
    CGFloat bottom = 8;
    CGFloat right = 5;
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    UIImage *backLine = [[UIImage imageNamed:@"select_line"] resizableImageWithCapInsets:insets];
    
    self.otherPHbackLine.image = backLine;
    self.otherCodebackLine.image = backLine;
    
    self.thirdPHBackLine.image = backLine;
    self.thirdCodeBackLine.image = backLine;
    
    
}

- (void)setVerificationButton
{
    //验证码button
    otherCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
    [self.otherSendView addSubview:otherCode];
    [otherCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.otherSendView).with.offset(0);
        make.right.equalTo(self.otherSendView).with.offset(0);
        make.bottom.equalTo(self.otherSendView).with.offset(0);
        make.top.equalTo(self.otherSendView).with.offset(0);
        
    }];
    [otherCode setTitle:@"发送验证码" forState:UIControlStateNormal];
    otherCode.titleLabel.font = [UIFont systemFontOfSize:15];
    [otherCode addTarget:self action:@selector(otherSendVification:) forControlEvents:UIControlEventTouchUpInside];
    otherCode.backgroundColor = NavColor;
    
    
    [otherCode addToucheHandler:^(JKCountDownButton*sender, NSInteger tag) {
        sender.enabled = NO;
        
        [sender startWithSecond:60];
        
        [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
            NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
            return title;
        }];
        [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
            countDownButton.enabled = YES;
            return @"重新发送";
            
        }];
        
    }];
    
    if (self.dataSource.count == 3) {
        thirdCode = [JKCountDownButton buttonWithType:UIButtonTypeCustom];
        [self.thirdSendView addSubview:thirdCode];
        [thirdCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.thirdSendView).with.offset(0);
            make.right.equalTo(self.thirdSendView).with.offset(0);
            make.bottom.equalTo(self.thirdSendView).with.offset(0);
            make.top.equalTo(self.thirdSendView).with.offset(0);
            
        }];
        [thirdCode setTitle:@"发送验证码" forState:UIControlStateNormal];
        thirdCode.titleLabel.font = [UIFont systemFontOfSize:15];
        [thirdCode addTarget:self action:@selector(otherSendVification:) forControlEvents:UIControlEventTouchUpInside];
        thirdCode.backgroundColor = NavColor;
        
        
        [thirdCode addToucheHandler:^(JKCountDownButton*sender, NSInteger tag) {
            sender.enabled = NO;
            
            [sender startWithSecond:60];
            
            [sender didChange:^NSString *(JKCountDownButton *countDownButton,int second) {
                NSString *title = [NSString stringWithFormat:@"剩余%d秒",second];
                return title;
            }];
            [sender didFinished:^NSString *(JKCountDownButton *countDownButton, int second) {
                countDownButton.enabled = YES;
                return @"重新发送";
                
            }];
            
        }];
    }

}

- (UIView *)footSighButton
{
    UIView *backView = [[UIView alloc]init];
    backView.backgroundColor = BackColor;
    
    self.selfbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.selfbtn.backgroundColor = NavColor;
    self.selfbtn.layer.masksToBounds = YES;
    self.selfbtn.layer.borderWidth = 1;
    self.selfbtn.layer.borderColor = NavColor.CGColor;
    [self.selfbtn setTitle:@"本方签名" forState:UIControlStateNormal];
    [self.selfbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.selfbtn addTarget:self action:@selector(selfbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:self.selfbtn];
    [self.selfbtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(backView).with.offset(10);
        make.centerY.equalTo(backView.mas_centerY);
        make.bottom.equalTo(backView).with.offset(10);
        make.top.equalTo(backView).with.offset(10);
        
    }];
    
    
    self.otherbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.otherbtn.backgroundColor = NavColor;
    self.otherbtn.layer.masksToBounds = YES;
    self.otherbtn.layer.borderWidth = 1;
    self.otherbtn.layer.borderColor = NavColor.CGColor;
    [self.otherbtn setTitle:@"对方签名" forState:UIControlStateNormal];
    [self.otherbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.otherbtn addTarget:self action:@selector(otherbtnClick) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:self.otherbtn];
    if (self.dataSource.count == 2) {
        [self.otherbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.selfbtn.mas_right).with.offset(3);
            make.centerY.equalTo(self.selfbtn.mas_centerY);
            make.right.equalTo(backView).with.offset(-10);
            make.width.mas_equalTo(self.selfbtn.mas_width);
            make.height.mas_equalTo(self.selfbtn.mas_height);
            
        }];
    }
    else if (self.dataSource.count == 3)
    {
        [self.otherbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.selfbtn.mas_right).with.offset(3);
            make.centerY.equalTo(self.selfbtn.mas_centerY);
            make.width.mas_equalTo(self.selfbtn.mas_width);
            make.height.mas_equalTo(self.selfbtn.mas_height);
            
        }];
        
        self.thirdbtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.thirdbtn.backgroundColor = NavColor;
        self.thirdbtn.layer.masksToBounds = YES;
        self.thirdbtn.layer.borderWidth = 1;
        self.thirdbtn.layer.borderColor = NavColor.CGColor;
        [self.thirdbtn setTitle:@"第三方签名" forState:UIControlStateNormal];
        [self.thirdbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.thirdbtn addTarget:self action:@selector(thirdbtnClick) forControlEvents:UIControlEventTouchUpInside];
        [backView addSubview:self.thirdbtn];
        [self.thirdbtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.otherbtn.mas_right).with.offset(3);
            make.centerY.equalTo(self.otherbtn.mas_centerY);
            make.right.equalTo(backView).with.offset(-10);
            make.width.mas_equalTo(self.otherbtn.mas_width);
            make.height.mas_equalTo(self.otherbtn.mas_height);
            
        }];
    }
    
    
    
    
    return backView;
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
