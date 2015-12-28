//
//  QueryParameter.m
//  TBRJL
//
//  Created by 程三 on 15/6/7.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "QueryParameter.h"

@implementation QueryParameter

-(id)init
{
    self = [super init];
    if(self)
    {
        _javaClass = @"com.longrise.LEAP.Base.Objects.QueryParameter";
        _sqlType = nil;
        _flag = nil;
        _skipExpression = @"false";
        _type = [[NSNumber alloc] initWithInt:0];
        _group = nil;
        _value = nil;
        _name = nil;
        
        /*
         "javaClass":"com.longrise.LEAP.Base.Objects.QueryParameter",
         "value":"b8cbbbc5f22b4570b3c879966df7a241",
         "skipExpression":false,
         "sqlType":null,
         "flag":11,
         "type":0,
         "group":null,
         "name":"userid"
         */
    }
    
    return self;
}

//获取这个对象的字典
-(NSDictionary *)getDicOfObject
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:_javaClass forKey:@"javaClass"];
    [dic setValue:_sqlType forKey:@"sqlType"];
    [dic setValue:_flag forKey:@"flag"];
    [dic setValue:[[NSNumber alloc] initWithBool:FALSE] forKey:@"skipExpression"];
    [dic setValue:_type forKey:@"type"];
    [dic setValue:_group forKey:@"group"];
    [dic setValue:_value forKey:@"value"];
    [dic setValue:_name forKey:@"name"];
    
    return dic;
}
@end
