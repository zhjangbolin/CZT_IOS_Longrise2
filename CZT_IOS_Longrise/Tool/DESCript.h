//
//  DESCript.h
//  KCKP
//
//  Created by zzy on 15/10/16.
//  Copyright (c) 2015年 zzy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface DESCript : NSObject

+ (NSString *)encrypt:(NSString *)sText encryptOrDecrypt:(CCOperation)encryptOperation key:(NSString *)key;

@end
