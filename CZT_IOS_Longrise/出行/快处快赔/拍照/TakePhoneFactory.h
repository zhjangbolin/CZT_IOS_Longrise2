//
//  TakePhoneFactory.h
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/11/28.
//  Copyright (c) 2015年 程三. All rights reserved.
//  照片工厂

#import <Foundation/Foundation.h>
#import "PhoneViewController.h"
@interface TakePhoneFactory : NSObject

//mark 1:单车 2:多车
+(PhoneViewController *)createPhoneViewController:(int)mark;

@end
