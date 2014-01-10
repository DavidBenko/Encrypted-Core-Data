//
//  NSData+AES256.h
//  Securis
//
//  Created by PRNDL1 on 10/14/13.
//  Copyright (c) 2013 PRNDL Development Studios, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSData (AES256)
- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;
- (NSData *)AES256EncryptWithKey:(NSString *)key Iv:(const void *)iv;
- (NSData *)AES256DecryptWithKey:(NSString *)key Iv:(const void *)iv;

@end
