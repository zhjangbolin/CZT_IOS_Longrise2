//
//  DetailEvaluateModel.h
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/17.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "JSONModel.h"
#import "EvaluateResultModel.h"
@interface DetailEvaluateModel : JSONModel

@property (nonatomic, strong) NSArray<EvaluateResultModel> *data;
@end
