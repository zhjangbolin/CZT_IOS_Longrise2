//
//  UserDefaultsUtil.h
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/12/8.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserDefaultsUtil : NSObject
+(void)saveNSUserDefaultsForInteger:(NSInteger)value forKey:(NSString *)key;

+(void)saveNSUserDefaultsForFloat:(float)value forKey:(NSString *)key;

+(void)saveNSUserDefaultsForDouble:(double)value forKey:(NSString *)key;

+(void)saveNSUserDefaultsForBOOL:(BOOL)value forKey:(NSString *)key;

+(void)saveNSUserDefaultsForObject:(id)value forKey:(NSString *)key;

+(id)getDataForKey:(NSString *)key;

+(void)removeAllUserDefaults;  //移除所有本地用户信息
@end
