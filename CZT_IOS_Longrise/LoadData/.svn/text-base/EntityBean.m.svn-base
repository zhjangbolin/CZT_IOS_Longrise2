//
//  EntityBean.m
//  TBRJL
//
//  Created by user on 15/7/10.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "EntityBean.h"

@implementation EntityBean

-(id)init
{
    self = [super init];
    if(self)
    {
        dic = [[NSMutableDictionary alloc] init];
        //[self setValue:@"com.longrise.LEAP.Base.Objects.EntityBean" forKey:@"javaClass"];
    }

    return  self;
}

-(NSObject *)objectForKey:(NSObject *)key
{
    if(nil != dic)
    {
        return [dic objectForKey:key];
    }
    return nil;
}
- (void)setValue:(id)value forKey:(NSString *)key
{
    if(nil != dic)
    {
        [dic setValue:value forKey:key];
    }
}

-(NSDictionary *)getDic
{
    return dic;
}

//set方法
//-(void)setIntKey:(NSString *)key value:(int)value
//{
//    if(nil != dic)
//    {
//        [dic setValue:[[NSNumber alloc] initWithInt:value] forKey:key];
//    }
//}
//-(void)setBoolkey:(NSString *)key value:(BOOL)value
//{
//    if(nil != dic)
//    {
//        [dic setValue:[[NSNumber alloc] initWithBool:value] forKey:key];
//    }
//}
//-(void)setFloatKey:(NSString *)key value:(float)value
//{
//    if(nil != dic)
//    {
//        [dic setValue:[[NSNumber alloc] initWithFloat:value] forKey:key];
//    }
//}
//-(void)setDoubleKey:(NSString *)key value:(double)value
//{
//    if(nil != dic)
//    {
//        [dic setValue:[[NSNumber alloc] initWithDouble:value] forKey:key];
//    }
//}
//-(void)setStringKey:(NSString *)key value:(NSString *)value
//{
//    if(nil != dic)
//    {
//        [dic setValue:value forKey:key];
//    }
//}
//-(void)setObjectKey:(NSString *)key value:(id)value
//{
//    if(nil != dic)
//    {
//        [dic setValue:value forKey:key];
//    }
//}
//
////get方法
//-(int)getIntForKey:(NSString *)key;
//{
//    if(dic != nil)
//    {
//        NSString *string = [dic objectForKey:key];
//        int i = [string intValue];
//        return i;
//    }
//    return -1;
//}
//-(BOOL)getBoolForkey:(NSString *)key
//{
//    if(dic != nil)
//    {
//        NSString *string = [dic objectForKey:key];
//        BOOL b = [string boolValue];
//        return b;
//    }
//    
//    return false;
//}
//-(float)getFloatForKey:(NSString *)key
//{
//    if(dic != nil)
//    {
//        NSString *string = [dic objectForKey:key];
//        float f = [string floatValue];
//        return f;
//    }
//    return -1;
//}
//-(double)getDoubleForKey:(NSString *)key
//{
//    if(dic != nil)
//    {
//        NSString *string = [dic objectForKey:key];
//        double d = [string doubleValue];
//        return d;
//    }
//    return -1;
//}
//-(NSString *)getStringForKey:(NSString *)key
//{
//    if(dic != nil)
//    {
//        NSString *string = [dic objectForKey:key];
//        return string;
//    }
//    return nil;
//}
//-(id)getObjectForKey:(NSString *)key
//{
//    if(dic != nil)
//    {
//        id obj = [dic objectForKey:key];
//        return obj;
//    }
//    return nil;
//}
//
//-(NSString *)getStringOfObject
//{
//    return [self objectToJson:dic];
//}
//
//- (NSString*)objectToJson:(NSObject *)object
//{
//    NSError *parseError = nil;
//    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&parseError];
//    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//}
//
//-(NSDictionary *)getNSDic
//{
//    return dic;
//}
@end
