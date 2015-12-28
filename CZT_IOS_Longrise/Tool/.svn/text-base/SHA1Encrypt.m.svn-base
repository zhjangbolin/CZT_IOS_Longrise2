//
//  SHA1Encrypt.m
//  DES加密
//
//  Created by OSch on 15/11/26.
//  Copyright © 2015年 OSch. All rights reserved.
//

#import "SHA1Encrypt.h"
#import <CommonCrypto/CommonDigest.h>
@implementation SHA1Encrypt


+ (NSString *)getSha1String:(NSString *)srcString
{
    const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString* result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    
    return result;
}
@end
