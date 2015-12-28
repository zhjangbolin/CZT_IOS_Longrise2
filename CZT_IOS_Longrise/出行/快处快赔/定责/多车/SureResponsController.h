//
//  SureResponsController.h
//  CZT_IOS_Longrise
//
//  Created by OSch on 15/12/3.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "PublicViewController.h"
#import "SignViewController.h"
#import "MBProgressHUD.h"
#import "JKCountDownButton.h"
@interface SureResponsController : PublicViewController<UITableViewDelegate,UITableViewDataSource,SignViewControllerDelegate,UITextFieldDelegate>
{
    JKCountDownButton *otherCode;
    JKCountDownButton *thirdCode;
}

@property (strong, nonatomic) IBOutlet UIView *usView;

@property (strong, nonatomic) IBOutlet UIView *otherView;

@property (strong, nonatomic) IBOutlet UIView *thirdView;


@property (strong, nonatomic) IBOutlet UIView *BackView;

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (weak, nonatomic) IBOutlet UITableView *sureTabView;

//对方 重发验证码View

@property (weak, nonatomic) IBOutlet UIView *otherSendView;


//第三方 重发验证码View

@property (weak, nonatomic) IBOutlet UIView *thirdSendView;

//确认生成责任书
@property (weak, nonatomic) IBOutlet UIButton *sureResponsBtn;

//签名按钮
@property (strong, nonatomic) UIButton *selfbtn;
@property (strong, nonatomic) UIButton *otherbtn;
@property (strong, nonatomic) UIButton *thirdbtn;


//案件号
@property (copy, nonatomic) NSString *appcaseno;
//事故选择
@property (strong, nonatomic) NSArray *describeData;
//事故详情描述
@property (copy, nonatomic) NSString *describeString;
//投保公司代码
@property (copy, nonatomic) NSString *companyCode;



//本方
@property (strong, nonatomic)NSString *UserName;
@property (strong, nonatomic)NSString *CarNumber;
@property (strong, nonatomic)NSString *CompanyName;
@property (strong, nonatomic)NSString *PhoneNumber;
@property (strong, nonatomic)NSString *DriverNumber;
@property (strong, nonatomic)NSString *usSureRespons;
//投保公司代码
@property (copy, nonatomic) NSString *usCompanyCode;

@property (weak, nonatomic) IBOutlet UILabel *usName;

@property (weak, nonatomic) IBOutlet UILabel *usCarNumber;

@property (weak, nonatomic) IBOutlet UILabel *usCompany;

@property (weak, nonatomic) IBOutlet UILabel *usPhoneNumber;

@property (weak, nonatomic) IBOutlet UILabel *usDirverNumber;
//责任认定
@property (weak, nonatomic) IBOutlet UILabel *usRespons;






//对方
@property (strong, nonatomic)NSString *otherUserName;
@property (strong, nonatomic)NSString *otherCarNumbers;
@property (strong, nonatomic)NSString *otherCompName;
@property (strong, nonatomic)NSString *otherPhoneNumbers;
@property (strong, nonatomic)NSString *otherDriNumber;
@property (strong, nonatomic)NSString *otherSureRespons;
//投保公司代码
@property (copy, nonatomic) NSString *otherCompanyCode;

@property (weak, nonatomic) IBOutlet UILabel *otherName;

@property (weak, nonatomic) IBOutlet UILabel *otherCarNumber;

@property (weak, nonatomic) IBOutlet UILabel *otherCompany;

@property (weak, nonatomic) IBOutlet UILabel *otherPhoneNumber;
@property (weak, nonatomic) IBOutlet UIImageView *otherPHbackLine;

//验证码
@property (weak, nonatomic) IBOutlet UITextField *otherVerificationCode;

@property (weak, nonatomic) IBOutlet UIImageView *otherCodebackLine;

@property (weak, nonatomic) IBOutlet UILabel *otherDirverNumber;
//责任认定
@property (weak, nonatomic) IBOutlet UILabel *otherRespons;







//其他
@property (strong, nonatomic)NSString *thirdUserName;
@property (strong, nonatomic)NSString *thirdCarNumbers;
@property (strong, nonatomic)NSString *thirdCompName;
@property (strong, nonatomic)NSString *thirdPhoneNum;
@property (strong, nonatomic)NSString *thirdDriverNum;
@property (strong, nonatomic)NSString *thirdSureRespons;
//投保公司代码
@property (copy, nonatomic) NSString *thirdCompanyCode;

@property (weak, nonatomic) IBOutlet UILabel *thirdName;

@property (weak, nonatomic) IBOutlet UILabel *thirdCarNumber;

@property (weak, nonatomic) IBOutlet UILabel *thirdCompany;

@property (weak, nonatomic) IBOutlet UILabel *thirdPhoneNumber;
@property (weak, nonatomic) IBOutlet UIImageView *thirdPHBackLine;
//验证码
@property (weak, nonatomic) IBOutlet UITextField *thirdVificationCode;

@property (weak, nonatomic) IBOutlet UIImageView *thirdCodeBackLine;

@property (weak, nonatomic) IBOutlet UILabel *thirdDirverNumber;
//责任认定
@property (weak, nonatomic) IBOutlet UILabel *thirdRespons;






@end
