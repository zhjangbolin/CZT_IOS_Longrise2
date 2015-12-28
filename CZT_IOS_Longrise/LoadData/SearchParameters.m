//
//  SearchParameters.m
//  TBRJL
//
//  Created by 程三 on 15/6/9.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "SearchParameters.h"
#import "QueryParameter.h"

@implementation SearchParameters

-(id)init
{
    self = [super init];
    if(self)
    {
        [self _initData];
    }
    
    return self;
}

-(void)_initData
{
    _pageNum = [[NSNumber alloc] initWithInt:-1];
    _pageSize = [[NSNumber alloc] initWithInt:-1];
    _pageCount = [[NSNumber alloc] initWithInt:-1];
    _name = NULL;//模型名
    _order = NULL;//排序字段
    _name2 = NULL;
    _extend = NULL;
    _parameters = NULL;//查询参数数组
    _fields = NULL;//查询字段数组
    _extendQuery = NULL;
    _groups = NULL;
    _pks = NULL;
    _cloudAppID = NULL;
    _distinct = NULL;
    _queryDebug = NULL;
    _fillCodeValue = @"false";//是否返回对应代码表的值
    _fillCNMetaData = @"false";
    _returnCodeValue = @"false";
    _toCount = @"false";
    _getCodeValue = @"false";
    
}

-(void)addParameter:(NSString *)name value:(id)object flag:(int)flag
{
    if(_parameters == nil || _parameters == NULL)
    {
        _parameters = [[NSMutableArray alloc] init];
    }
    
    QueryParameter *query = [[QueryParameter alloc] init];
    query.name = name;
    query.value = object;
    query.flag = [[NSNumber alloc] initWithInt:flag];
    NSDictionary *dic = [query getDicOfObject];
    [_parameters addObject:dic];
}


-(NSString *)getStringOfObject
{
    //定义一个字典
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setValue:@"com.longrise.LEAP.Base.Objects.SearchParameters" forKey:@"javaClass"];
    [dic setValue:_parameters forKey:@"parameters"];
    [dic setValue:_getCodeValue forKey:@"getCodeValue"];
    [dic setValue:_fillCodeValue forKey:@"fillCodeValue"];
    [dic setValue:_pageSize forKey:@"pageSize"];
    [dic setValue:_toCount forKey:@"toCount"];
    [dic setValue:_returnCodeValue forKey:@"returnCodeValue"];
    [dic setValue:_extendQuery forKey:@"extendQuery"];
    [dic setValue:_name forKey:@"name"];
    [dic setValue:_distinct forKey:@"distinct"];
    [dic setValue:_pageCount forKey:@"pageCount"];
    [dic setValue:_fillCNMetaData forKey:@"fillCNMetaData"];
    [dic setValue:_groups forKey:@"groups"];
    [dic setValue:_name2 forKey:@"name2"];
    [dic setValue:_cloudAppID forKey:@"cloudAppID"];
    [dic setValue:_pageNum forKey:@"pageNum"];
    [dic setValue:_order forKey:@"order"];
    [dic setValue:_extend forKey:@"extend"];
    [dic setValue:_pks forKey:@"pks"];
    
    return [self objectToJson:dic];
}

- (NSString*)objectToJson:(NSObject *)object
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

-(void)addFieldName:(NSString *)fieldName
{
    if(_fields == nil || _fields == NULL)
    {
        _fields = [[NSMutableArray alloc] init];
    }
    [_fields addObject:fieldName];
}

@end
