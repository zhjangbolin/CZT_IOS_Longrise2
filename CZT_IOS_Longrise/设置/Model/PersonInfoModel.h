//
//  PersonInfoModel.h
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/22.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "JSONModel.h"
#import "PersonInfoDataModel.h"
@interface PersonInfoModel : JSONModel

@property (nonatomic, strong) PersonInfoDataModel *data;

@end
