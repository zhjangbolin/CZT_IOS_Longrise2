//
//  DutyViewController.h
//  Test
//
//  Created by 张博林 on 15/12/14.
//  Copyright © 2015年 张博林. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "curl.h"

@interface DutyViewController : UIViewController{
    CURL *_curl;
}

//事故人数
@property (strong, nonatomic) NSMutableArray *dataSource;


//案件号
@property (copy, nonatomic) NSString *appcaseno;
//事故选择
@property (strong, nonatomic) NSArray *describeData;
//事故详情描述
@property (copy, nonatomic) NSString *describeString;

//本方
@property (strong, nonatomic)NSString *UserName;
@property (strong, nonatomic)NSString *CarNumber;
@property (strong, nonatomic)NSString *CompanyName;
@property (strong, nonatomic)NSString *phoneNumber;
@property (strong, nonatomic)NSString *DriverNumber;
@property (strong, nonatomic)NSString *usSureRespons;
//投保公司代码
@property (copy, nonatomic) NSString *usCompanyCode;
//事故人的信息
@property (strong, nonatomic)  NSMutableDictionary *usInfoDict;

//对方
@property (strong, nonatomic)NSString *otherUserName;
@property (strong, nonatomic)NSString *otherCarNumbers;
@property (strong, nonatomic)NSString *otherCompName;
@property (strong, nonatomic)NSString *otherPhoneNumbers;
@property (strong, nonatomic)NSString *otherDriNumber;
@property (strong, nonatomic)NSString *otherSureRespons;
//投保公司代码
@property (copy, nonatomic) NSString *otherCompanyCode;
//事故人的信息
@property (strong, nonatomic)  NSMutableDictionary *otherInfoDict;

//其他
@property (strong, nonatomic)NSString *thirdUserName;
@property (strong, nonatomic)NSString *thirdCarNumbers;
@property (strong, nonatomic)NSString *thirdCompName;
@property (strong, nonatomic)NSString *thirdPhoneNum;
@property (strong, nonatomic)NSString *thirdDriverNum;
@property (strong, nonatomic)NSString *thirdSureRespons;
//投保公司代码
@property (copy, nonatomic) NSString *thirdCompanyCode;
//事故人的信息
@property (strong, nonatomic)  NSMutableDictionary *thirdInfoDict;

@end
