//
//  PartiesConcernedController.h
//  CZT_IOS_Longrise
//
//  Created by OSch on 15/12/11.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "PublicViewController.h"
#import "UISelectListView.h"
@interface PartiesConcernedController : PublicViewController<UISelectListViewDelegate,UITextFieldDelegate>
{
    //车牌的省市
    UISelectListView *carSelectCities;
    //投保公司
    UISelectListView *usSelectCompany;
}

@property (weak, nonatomic) IBOutlet UIView *infoView;

//姓名
@property (weak, nonatomic) IBOutlet UITextField *driverName;
//选择车牌省市的View
@property (weak, nonatomic) IBOutlet UIView *carCityiesView;
//车牌号
@property (weak, nonatomic) IBOutlet UITextField *crNumber;

@property (weak, nonatomic) IBOutlet UIImageView *carBackViewLine;

//选择公司的View
@property (weak, nonatomic) IBOutlet UIView *companyView;

//投保公司代码
@property (copy, nonatomic) NSString *usCompanyCode;

//电话号码
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;

@property (weak, nonatomic) IBOutlet UIImageView *usPHBackViewLine;


//驾驶证号
@property (weak, nonatomic) IBOutlet UITextField *driverNumber;

//案件号
@property (copy, nonatomic) NSString *appcaseno;

@end
