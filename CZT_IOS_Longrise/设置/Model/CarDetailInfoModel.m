//
//  CarDetailInfoModel.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/22.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "CarDetailInfoModel.h"

@implementation CarDetailInfoModel

+(JSONKeyMapper *)keyMapper{
    
    JSONKeyMapper *keyMapper = [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"Id"}];
    
    return keyMapper;
}

@end
