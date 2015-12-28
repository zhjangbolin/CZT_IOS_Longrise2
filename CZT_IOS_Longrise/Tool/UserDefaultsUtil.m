//
//  UserDefaultsUtil.m
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/12/8.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "UserDefaultsUtil.h"

@implementation UserDefaultsUtil

+(void)saveNSUserDefaultsForInteger:(NSInteger)value forKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:value forKey:key];
}

+(void)saveNSUserDefaultsForFloat:(float)value forKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setFloat:value forKey:key];
}

+(void)saveNSUserDefaultsForDouble:(double)value forKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setDouble:value forKey:key];
}

+(void)saveNSUserDefaultsForBOOL:(BOOL)value forKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:value forKey:key];
}

+(void)saveNSUserDefaultsForObject:(id)value forKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:value forKey:key];
}

+(id)getDataForKey:(NSString *)key
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return  [userDefaults objectForKey:key];
}

+(void)removeAllUserDefaults{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *userDic = [userDefaults dictionaryRepresentation];
    for (NSString *key in [userDic allKeys]) {
        [userDefaults removeObjectForKey:key];
        [userDefaults synchronize];
    }
}
@end
