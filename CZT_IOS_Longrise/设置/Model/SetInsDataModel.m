//
//  SetInsDataModel.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/19.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "SetInsDataModel.h"

@implementation SetInsDataModel
+(JSONKeyMapper *)keyMapper{
    
    JSONKeyMapper *keyMapper = [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"Id"}];
    
    return keyMapper;
}
@end
