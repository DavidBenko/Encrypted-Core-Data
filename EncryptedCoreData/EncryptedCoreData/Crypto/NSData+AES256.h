//
//  NSData+AES256.h
//  Securis
//
//  Created by PRNDL1 on 10/14/13.
//  Copyright (c) 2013 PRNDL Development Studios, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>
#import "DataGenerator.h"

@interface NSData (AES256)

+ (NSData *)AESKeyForPassword:(NSString *)password salt:(NSData *)salt;
- (NSData *)encryptedDataWithPassword:(NSString *)password iv:(NSData **)iv salt:(NSData **)salt error:(NSError **)error;
- (NSData *)decryptedDataWithPassword:(NSString *)password iv:(NSData *)iv salt:(NSData *)salt error:(NSError **)error;

@end
