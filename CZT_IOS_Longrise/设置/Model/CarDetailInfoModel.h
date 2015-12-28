//
//  CarDetailInfoModel.h
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/22.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "JSONModel.h"

@interface CarDetailInfoModel : JSONModel

@property (nonatomic, copy) NSString *Id;
@property (nonatomic, copy) NSString *enginenumber;
@property (nonatomic, copy) NSString *lcipusertableid;
@property (nonatomic, copy) NSString *isapprove;
@property (nonatomic, copy) NSString *carno;
@property (nonatomic, copy) NSString *identificationnum;
@property (nonatomic, copy) NSString *state;

@end
