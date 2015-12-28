//
//  FillInformationController.h
//  CZT_IOS_Longrise
//
//  Created by OSch on 15/12/3.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "PublicViewController.h"
#import "UISelectListView.h"


@interface FillInformationController : PublicViewController <UITableViewDelegate,UITextFieldDelegate>
{
    //本方
    //车牌的省市
    UISelectListView *carSelectCities;
    //投保公司
    UISelectListView *usSelectCompany;
    
    //对方
    //车牌的省市
    UISelectListView *otherCarSelectCities;
    //投保公司
    UISelectListView *otherSelectCompany;
    
    //其他
    //车牌的省市
    UISelectListView *thirdCarSelectCities;
    //投保公司
    UISelectListView *thirdSelectCompany;
}
//案件号
@property (copy, nonatomic) NSString *appcaseno;
//事故选择
@property (strong, nonatomic) NSArray *describeData;
//事故详情描述
@property (copy, nonatomic) NSString *describeString;

@property (weak, nonatomic) IBOutlet UIView *toolView;


@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;

@property (strong, nonatomic) IBOutlet UIView *thirdView;

@property (weak, nonatomic) IBOutlet UIButton *nextStep;
@property (weak, nonatomic) IBOutlet UIButton *deletCar;



//本方驾驶人信息
//驾驶人姓名
@property (weak, nonatomic) IBOutlet UITextField *name;

//放置车牌省市的View
@property (weak, nonatomic) IBOutlet UIView *carView;

@property (weak, nonatomic) IBOutlet UIImageView *carBackViewLine;

//车牌号
@property (copy, nonatomic)  NSString *reciveCarNumber;
@property (weak, nonatomic) IBOutlet UITextField *carNumber;

//放置公司名label 的view
@property (weak, nonatomic) IBOutlet UIView *companyView;

@property (copy, nonatomic) NSString *usCompanyName;
//投保公司代码
@property (copy, nonatomic) NSString *usCompanyCode;
//电话号码
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;

@property (weak, nonatomic) IBOutlet UIImageView *usPHBackLine;

//驾驶证号
@property (weak, nonatomic) IBOutlet UITextField *driverNumber;


//对方驾驶人信息

//驾驶人姓名
@property (weak, nonatomic) IBOutlet UITextField *otherPartyName;

//放置车牌省市的View

@property (weak, nonatomic) IBOutlet UIView *otherCarView;


//车牌号
@property (weak, nonatomic) IBOutlet UITextField *otherCarNumber;

@property (weak, nonatomic) IBOutlet UIImageView *otherCarBackViewLine;

//放置公司名label 的view
@property (weak, nonatomic) IBOutlet UIView *otherPartyCompanyView;
//投保公司代码
@property (copy, nonatomic) NSString *otherCompanyCode;

//电话号码
@property (weak, nonatomic) IBOutlet UITextField *otherPartyPhoneNumber;



//驾驶证号
@property (weak, nonatomic) IBOutlet UITextField *otherPartyDriverNumber;


//其他驾驶人信息


//驾驶人姓名
@property (weak, nonatomic) IBOutlet UITextField *thirdPartyName;

//放置车牌省市的View
@property (weak, nonatomic) IBOutlet UIView *thirdCarView;


//车牌号
@property (weak, nonatomic) IBOutlet UITextField *thirdCarNumber;

@property (weak, nonatomic) IBOutlet UIImageView *thirdCarBackViewLine;

//放置公司名label 的view
@property (weak, nonatomic) IBOutlet UIView *thirdPartyCompanyView;
//投保公司代码
@property (copy, nonatomic) NSString *thirdCompanyCode;

//电话号码
@property (weak, nonatomic) IBOutlet UITextField *thirdPartyPhoneNumber;



//驾驶证号
@property (weak, nonatomic) IBOutlet UITextField *thirdPartyDriverNumber;
@property (weak, nonatomic) IBOutlet UIView *hiddenThirdView;

@end
