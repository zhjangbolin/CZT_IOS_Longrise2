//
//  ControversialController.m
//  CZT_IOS_Longrise
//
//  Created by OSch on 15/12/14.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "ControversialController.h"
#import <Masonry.h>
#import "CZT_IOS_Longrise.pch"
#import "SureResponsController.h"
#import "IMViewController.h"
#import "Globle.h"

@interface ControversialController ()
{
    NSString *usduty;
    NSString *otherduty;
    NSString *thirdduty;
}
@end

@implementation ControversialController

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   self.title = @"指导定责";
    
    //展示事故人信息的View
    [self setShowView];
    
    //指导定责的责任类型
    [self setDuty];
    
    //加载数据
    [self loadData];
    
}
-(void)setDuty
{
//    NSNumber *dutytype = [NSNumber numberWithInt:0];
//    NSNumber *dutytype1 = [NSNumber numberWithInt:1];
//    NSNumber *dutytype2 = [NSNumber numberWithInt:2];
    NSDictionary *usdic = [[NSDictionary alloc]init];
    NSDictionary *otherdic = [[NSDictionary alloc]init];
    NSDictionary *thirddic = [[NSDictionary alloc]init];
    usdic = self.dutyData[0];
    otherdic = self.dutyData[1];
    
    if (self.dutyData.count == 2)
    {
        thirddic = self.dutyData[1];
    }
    
    if (self.dutyData.count == 3)
    {
        thirddic = self.dutyData[2];
    }
   
    for (NSDictionary *dic in self.dutyData) {
        if ([dic[@"casecarno"] isEqualToString:self.usInfoDict[@"casecarno"]])
        {
            if ([dic[@"dutytype"]isEqualToString:@"0"]) {
                usduty = @"全责";
            }else if ([dic[@"dutytype"] isEqualToString:@"1"])
            {
                usduty = @"无责";
            }else if ([dic[@"dutytype"] isEqualToString:@"2"])
            {
                usduty = @"同责";
            }
                
        }
        else if ([dic[@"casecarno"] isEqualToString:self.otherInfoDict[@"casecarno"]])
        {
            if ([dic[@"dutytype"]isEqualToString:@"0"]) {
                otherduty = @"全责";
            }else if ([dic[@"dutytype"] isEqualToString:@"1"])
            {
                otherduty = @"无责";
            }else if ([dic[@"dutytype"] isEqualToString:@"2"])
            {
                otherduty = @"同责";
            }
        }
        else if ([dic[@"casecarno"] isEqualToString:self.thirdInfoDict[@"casecarno"]])
        {
            if ([dic[@"dutytype"]isEqualToString:@"0"]) {
                thirdduty = @"全责";
            }else if ([dic[@"dutytype"] isEqualToString:@"1"])
            {
                thirdduty = @"无责";
            }else if ([dic[@"dutytype"] isEqualToString:@"2"])
            {
                thirdduty = @"同责";
            }
        }
    }
    
}


- (void)loadData
{
   
    //本方
    self.usName.text = self.usInfoDict[@"carownname"];
    self.usCarNumber.text = self.usInfoDict[@"casecarno"];
    self.usCompanyName.text = self.usInfoDict[@"inscomname"];
    self.usPhoneNumber.text = self.usInfoDict[@"carownphone"];
    self.usDirverNumber.text = self.usInfoDict[@"driverno"];
//    self.usRespons.text = self.infoDict[@"carownname"];
    self.usRespons.text = usduty;
    
    //对方
    self.otherName.text = self.otherInfoDict[@"carownname"];
    self.otherCarNumber.text = self.otherInfoDict[@"casecarno"];
    self.otherCompanyName.text = self.otherInfoDict[@"inscomname"];
    self.otherPhoneNumber.text = self.otherInfoDict[@"carownphone"];
    self.otherDirverNumber.text = self.otherInfoDict[@"driverno"];
//    self.otherRespons.text = self.infoDict[@"carownname"];
    self.otherRespons.text = otherduty;
    
    //第三方
    self.thirdName.text = self.thirdInfoDict[@"carownname"];
    self.thirdCarName.text = self.thirdInfoDict[@"casecarno"];
    self.thirdCompanyName.text = self.thirdInfoDict[@"inscomname"];
    self.thirdPhoneNumber.text = self.thirdInfoDict[@"carownphone"];
    self.thirdDirverNumber.text = self.thirdInfoDict[@"driverno"];
//    self.thirdRespons.text = self.infoDict[@"carownname"];
    self.thirdRespons.text = thirdduty;
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

- (void)setShowView
{
    self.backSrollView.contentSize = CGSizeMake(0, self.dataSource.count * 330);
    CGFloat pading = 20;
    NSArray *ietms = [[NSBundle mainBundle]loadNibNamed:@"ControversialView" owner:self options:nil];

    for (int i = 0; i < self.dataSource.count; i++)
    {
        UIView *views = ietms[i];
        [self.backSrollView addSubview:views];
        [views mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(300);
            make.left.equalTo(self.backSrollView).with.offset(0);
            make.top.mas_equalTo((views.frame.origin.x + views.frame.size.height + pading)* i + pading);
            
            make.width.mas_equalTo(self.backSrollView.mas_width);
        }];
    }
    
    self.agreementBtn.layer.borderColor=NavColor.CGColor;
    self.agreementBtn.layer.borderWidth = 1;
    self.agreementBtn.layer.masksToBounds = YES;
    
}

#pragma mark 不认可
- (IBAction)unAgreementClick:(id)sender {
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"交警在线沟通",@"交警电话沟通",@"交警现场处理", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
}

#pragma mark 认可
- (IBAction)agreemrntClick:(id)sender {
    SureResponsController *sureResVC = [[SureResponsController alloc] init];
    sureResVC.hidesBottomBarWhenPushed = YES;
    sureResVC.dataSource = self.dataSource;
    [self passInfomation:sureResVC];
    [self.navigationController pushViewController:sureResVC animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        IMViewController *imView = [[IMViewController alloc]init];
        imView.hidesBottomBarWhenPushed = YES;
        imView.infoRoadName = self.appcaseno;
//           imView.infoRoadName = @"2015110160003333302656534";
        imView.infoAccount = self.usPhoneNumber.text;
//           imView.infoAccount = @"18907172640";
        [self.navigationController pushViewController:imView animated:YES];
    }
    else if (buttonIndex == 1)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"你要拨打112吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"呼叫", nil];
        [alert show];
    }
    else if (buttonIndex == 2)
    {
        NSMutableDictionary *bean2 = [[NSMutableDictionary alloc] init];
        [bean2 setValue:self.appcaseno forKey:@"appcaseno"];
        [bean2 setValue:self.describeString forKey:@"appphone"];
        [bean2 setValue:@"0" forKey:@"casestate"];
        [bean2 setValue:[self currentDate] forKey:@"statedate"];
        [bean2 setValue:[Globle getInstance].loadDataName forKey:@"username"];
        [bean2 setValue:[Globle getInstance].loadDataPass forKey:@"password"];
        [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].serviceURL ServiceName:[NSString stringWithFormat:@"%@/zdsubmitcanel",kckpzcslrest] params:bean2 httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
            
            NSLog(@"现场处理  %@",result);
            NSLog(@"sheng  %@",result[@"redes"]);
            NSDictionary *dic = result;
            NSString *restate = dic[@"restate"];
            //  NSLog(@"%@",dic);
            if ([restate isEqualToString:@"0"]) {
                
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已通知交警现场处理！！！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
                NSMutableArray *navigationArray = [[NSMutableArray alloc] initWithArray: self.navigationController.viewControllers];
                [self.navigationController popToViewController:[navigationArray objectAtIndex:1] animated:YES];
                
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"通知交警现场处理失败，请重新发送！！！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }
        } ];
    }
   
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://112"]];
    }
}
-(void)passInfomation:(SureResponsController *)VC
{
    VC.dataSource = self.dataSource;
    VC.describeData = self.describeData;
    VC.appcaseno = self.appcaseno;
    VC.describeString = self.describeString;
    
    //本方
    VC.UserName = self.usName.text;
    VC.CarNumber = self.usCarNumber.text;
    VC.CompanyName = self.usCompanyName.text;
    VC.PhoneNumber = self.usPhoneNumber.text;
    VC.DriverNumber = self.usDirverNumber.text;
    VC.usSureRespons = usduty;
    VC.usCompanyCode = self.otherCompanyCode;
    
    //对方
    VC.otherUserName = self.otherName.text;
    VC.otherCarNumbers = self.otherCarNumber.text;
    VC.otherCompName = self.otherCompanyName.text;
    VC.otherPhoneNumbers = self.otherPhoneNumber.text;
    VC.otherDriNumber = self.otherDirverNumber.text;
    VC.otherSureRespons = otherduty;
    VC.otherCompanyCode = self.usCompanyCode;
    
    //其他
    VC.thirdUserName = self.thirdName.text;
    VC.thirdCarNumbers = self.thirdCarName.text;
    VC.thirdCompName = self.thirdCompanyName.text;
    VC.thirdPhoneNum = self.thirdPhoneNumber.text;
    VC.thirdDriverNum = self.thirdDirverNumber.text;
    VC.thirdSureRespons = thirdduty;
    VC.thirdCompanyCode = self.thirdCompanyCode;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}



@end
