//
//  InsuranceReportController.m
//  CZT_IOS_Longrise
//
//  Created by OSch on 15/12/11.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "InsuranceReportController.h"
#import "Globle.h"
#import "CZT_IOS_Longrise.pch"
#import "HomeViewController.h"
#import "FVCustomAlertView.h"

extern NSMutableDictionary *caseDict;
extern NSMutableDictionary *onlyCaseDict;
extern NSNumber *caseDutyType;

@interface InsuranceReportController ()<UIAlertViewDelegate>
{
    FVCustomAlertView *fvalertView;
}
@end

@implementation InsuranceReportController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:NotficationNameForInsurance];
}
#pragma mark -  保险报案
- (IBAction)reportCase:(id)sender {
    
    if (caseDict) {
        if ([caseDutyType isEqualToNumber:[NSNumber numberWithInt:1]]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您是无责任方，暂不允许报案！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            [self upCaseInormationCompany:caseDict];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        
    }
    else if (onlyCaseDict)
    {
        [self upCaseInormationCompany:onlyCaseDict];
    }
    else if (self.historyCaseDict)
    {
        [self upCaseInormationCompany:self.historyCaseDict];
    }
    
    
    
}
#pragma mark -  暂不报案
- (IBAction)unReportCase:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)upCaseInormationCompany:(NSMutableDictionary *)dict
{
    fvalertView = [[FVCustomAlertView alloc]init];
    [fvalertView showAlertWithonView:self.view Width:100 height:100 contentView:nil cancelOnTouch:false Duration:0];
    [[Globle getInstance].service requestWithServiceIP:[Globle getInstance].serviceURL ServiceName:[NSString stringWithFormat:@"%@/zdsubmitcaseinforinscompany",kckpzcslrest] params:dict httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        [fvalertView dismiss];
        NSLog(@"保险报案  %@",result);
        NSLog(@"resdes = %@",result[@"redes"]);
        if ([result[@"redes"] isEqualToString:@"成功"]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"已报案，请耐心等待" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"报案失败，请检查您的网络！！！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } ];
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
