//
//  HistoryModel.m
//  CZT_IOS_Longrise
//
//  Created by 张博林 on 15/12/16.
//  Copyright © 2015年 程三. All rights reserved.
//

#import "HistoryModel.h"

@implementation HistoryModel
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    //NSLog(@"出错的键%@",key);
}

-(instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}

@end
