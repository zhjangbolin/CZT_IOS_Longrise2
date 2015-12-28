//
//  Demo.m
//  KCKPLeader
//
//  Created by 程三 on 15/11/26.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "Demo.h"
#import "UIViewExt.h"
#import "Util.h"
#import "Globle.h"
#import "NSString+NSStringMD5.h"

@implementation Demo

-(void)loadData
{
    
    NSString *name = @"110000002000";
    NSString *pass = [@"888888a" md5];
    NSMutableDictionary *bean = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *childBean = [[NSMutableDictionary alloc] init];
    [childBean setValue:@"15102722895" forKey:@"phonenumber"];
    [childBean setValue:[@"888888" md5] forKey:@"userpwd"];
    [childBean setValue:@"123456" forKey:@"loginip"];
    [bean setValue:childBean forKey:@"userbean"];
    childBean = nil;
    
    [bean setValue:name forKey:@"username"];
    [bean setValue:pass forKey:@"password"];
    
    //该值时一个定值
    NSString *ServiceUrl = @"http://192.168.3.208:86/KCKP/restservices/kckpzcslrest/";
    
    [[Globle getInstance].service requestWithServiceIP:ServiceUrl ServiceName:@"kckpAppLogin" params:bean httpMethod:@"POST" resultIsDictionary:YES completeBlock:^(id result) {
        
        NSDictionary *dic = result;
        NSLog(@"result:%@",dic);
        
    } ];
    
}

@end
