//
//  HRDataModel.m
//  CZT_IOS_Longrise
//
//  Created by Siren on 15/12/21.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "HRDataModel.h"

@implementation HRDataModel
+(BOOL)propertyIsOptional:(NSString *)propertyName{
    return YES;
}

+(JSONKeyMapper *)keyMapper{
    
    JSONKeyMapper *keyMapper = [[JSONKeyMapper alloc]initWithDictionary:@{@"id":@"Id"}];
    return keyMapper;
}
@end
