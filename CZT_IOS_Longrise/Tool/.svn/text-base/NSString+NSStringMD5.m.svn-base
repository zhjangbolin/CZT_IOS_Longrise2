//
//  NSString+NSStringMD5.m
//  TBRJL
//
//  Created by 程三 on 15/6/7.
//  Copyright (c) 2015年 程三. All rights reserved.
//

#import "NSString+NSStringMD5.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (NSStringMD5)

-(NSString *) md5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), digest );
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

@end
