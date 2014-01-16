//
//  EncryptionTransformer.m
//  Securis
//
//  Created by PRNDL1 on 10/31/13.
//  Copyright (c) 2013 PRNDL Development Studios, LLC. All rights reserved.
//

#import "EncryptionTransformer.h"

@implementation EncryptionTransformer

+ (Class)transformedValueClass
{
    return [NSData class];
}

+ (BOOL)allowsReverseTransformation
{
    return YES;
}

- (NSString*)key
{
    /*
     * Try to grab the key from the keychain
     * if a key doesn't exist, generate a new one and store it in the keychain
     */
    
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc]initWithIdentifier:@"Encryption_Key" accessGroup:nil];
    if ([keychainItem objectForKey:(__bridge id)kSecAttrService] && [(NSString *)[keychainItem objectForKey:(__bridge id)kSecAttrService] length] > 0) {
        return [keychainItem objectForKey:(__bridge id)kSecAttrService];
    }
    else {
        NSString *secret = [DataGenerator createRandomStringOfLength:32];
        [keychainItem setObject:secret forKey:(__bridge id)kSecAttrService];
        return secret;
    }
}

- (id)transformedValue:(NSData*)data
{
    // If there's no key, don't try to transform the data
    if ([self key] == nil || data == nil) return data;
    
    NSData* iv = nil;
    NSData* salt = nil;
    NSError *err = nil;
    
    NSData* encryptedData = [data encryptedDataWithPassword:[self key] iv:&iv salt:&salt error:&err];
    
    NSLog(@"Iv: %@",iv);
    NSLog(@"Salt: %@",salt);
    
    // Prepend IV to the encrypted data
    NSMutableData* mutableData = [NSMutableData dataWithData:iv];
    [mutableData appendData:salt];
    [mutableData appendData:encryptedData];
    return mutableData;
}

- (id)reverseTransformedValue:(NSData*)data
{
    // If there's no key, don't try to transform the data
    if ([self key] == nil || data == nil) return data;
    
    // The IV was stored in the first 128bits of the data
    NSData* iv = [data subdataWithRange:NSMakeRange(0, kCCBlockSizeAES128)];
    NSData* salt = [data subdataWithRange:NSMakeRange(kCCBlockSizeAES128, 8)];
    
    NSLog(@"Iv: %@",iv);
    NSLog(@"Salt: %@",salt);
    
    // Remove the IV from the encrypted data
    NSMutableData* mutableData = [NSMutableData dataWithData:data];
    [mutableData replaceBytesInRange:NSMakeRange(0, kCCBlockSizeAES128 + 8) withBytes:NULL length:0];
    
    // Decrypt remaining data
    NSError *err = nil;
    NSData *decrypted = [mutableData decryptedDataWithPassword:[self key] iv:iv salt:salt error:&err];
    return decrypted;
}
@end