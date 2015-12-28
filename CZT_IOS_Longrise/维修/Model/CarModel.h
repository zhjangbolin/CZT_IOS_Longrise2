//
//  CarModel.h
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/17.
//  Copyright © 2015年 程三. All rights reserved.
//
//此为车辆管理模型
#import "JSONModel.h"

@protocol CarModel <NSObject>

@end

@interface CarModel : JSONModel
@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *enginenumber;
@property (nonatomic, copy) NSString *approvetime;
@property (nonatomic, copy) NSString *redes;
@property (nonatomic, copy) NSString *identificationnum;//carvin
@property (nonatomic, copy) NSString *carownername;
@property (nonatomic, copy) NSString *lcipusertableid;
@property (nonatomic, copy) NSString *usertype;
@property (nonatomic, copy) NSString *brandtype;
@property (nonatomic, copy) NSString *cartype;
@property (nonatomic, copy) NSString *carno;
@property (nonatomic, copy) NSString *usertypepre;
@end
