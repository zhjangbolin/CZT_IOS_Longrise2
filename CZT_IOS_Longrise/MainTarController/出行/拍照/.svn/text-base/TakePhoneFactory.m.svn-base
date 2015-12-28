//
//  TakePhoneFactory.m
//  CZT_IOS_Longrise
//
//  Created by 程三 on 15/11/28.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "TakePhoneFactory.h"
#import "MoreCarViewController.h"
#import "OneCarViewController.h"

@implementation TakePhoneFactory

#pragma mark 1:单车 2:多车
+(PhoneViewController *)createPhoneViewController:(int)mark
{
    PhoneViewController *phoneViewController = nil;
    switch (mark)
    {
        case 1:
        {
            phoneViewController = [[OneCarViewController alloc] init];
            break;
        }
        case 2:
        {
            phoneViewController = [[MoreCarViewController alloc] init];
            break;
        }
    }
    
    return phoneViewController;
}
@end
