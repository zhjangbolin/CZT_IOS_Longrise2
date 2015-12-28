//
//  ControversialController.h
//  CZT_IOS_Longrise
//
//  Created by OSch on 15/12/14.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "PublicViewController.h"

@interface ControversialController : PublicViewController<UIActionSheetDelegate,UIAlertViewDelegate>

//事故人数
@property (strong, nonatomic) NSMutableArray *dataSource;
//责任类型数组
@property (strong, nonatomic) NSArray *dutyData;

//案件号
@property (copy, nonatomic) NSString *appcaseno;
//事故选择
@property (strong, nonatomic) NSArray *describeData;
//事故详情描述
@property (copy, nonatomic) NSString *describeString;



@property (weak, nonatomic) IBOutlet UIScrollView *backSrollView;

//xib的View
@property (strong, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIButton *unAgreementBtn;

@property (weak, nonatomic) IBOutlet UIButton *agreementBtn;



//本方
@property (weak, nonatomic) IBOutlet UILabel *usName;

@property (weak, nonatomic) IBOutlet UILabel *usCarNumber;

@property (weak, nonatomic) IBOutlet UILabel *usCompanyName;

@property (weak, nonatomic) IBOutlet UILabel *usPhoneNumber;

@property (weak, nonatomic) IBOutlet UILabel *usDirverNumber;

@property (weak, nonatomic) IBOutlet UILabel *usRespons;

//事故人的信息
@property (strong, nonatomic)  NSMutableDictionary *usInfoDict;

//投保公司代码
@property (copy, nonatomic) NSString *usCompanyCode;

//对方

@property (weak, nonatomic) IBOutlet UILabel *otherName;

@property (weak, nonatomic) IBOutlet UILabel *otherCarNumber;

@property (weak, nonatomic) IBOutlet UILabel *otherCompanyName;

@property (weak, nonatomic) IBOutlet UILabel *otherPhoneNumber;

@property (weak, nonatomic) IBOutlet UILabel *otherDirverNumber;

@property (weak, nonatomic) IBOutlet UILabel *otherRespons;

//事故人的信息
@property (strong, nonatomic)  NSMutableDictionary *otherInfoDict;

//投保公司代码
@property (copy, nonatomic) NSString *otherCompanyCode;

//第三方

@property (weak, nonatomic) IBOutlet UILabel *thirdName;

@property (weak, nonatomic) IBOutlet UILabel *thirdCarName;

@property (weak, nonatomic) IBOutlet UILabel *thirdCompanyName;

@property (weak, nonatomic) IBOutlet UILabel *thirdPhoneNumber;

@property (weak, nonatomic) IBOutlet UILabel *thirdDirverNumber;

@property (weak, nonatomic) IBOutlet UILabel *thirdRespons;

//事故人的信息
@property (strong, nonatomic)  NSMutableDictionary *thirdInfoDict;

//投保公司代码
@property (copy, nonatomic) NSString *thirdCompanyCode;

@end
