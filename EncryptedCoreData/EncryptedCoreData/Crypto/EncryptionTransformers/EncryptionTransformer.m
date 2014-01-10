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
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc]initWithIdentifier:@"Securis_Encryption_Key" accessGroup:nil];
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
    // If there's no key (e.g. during a data migration), don't try to transform the data
    if ([self key] == nil || data == nil) return data;
    
    // Use another NSData category method (left as an exercise
    // to the reader) to randomly generate the IV data
    NSData* iv = [DataGenerator createRandomDataOfLength:32];
    data = [data AES256EncryptWithKey:[self key] Iv:iv.bytes];
    // Return a data object that includes the IV with the
    // encrypted data appended
    NSMutableData* mutableData = [NSMutableData dataWithData:iv];
    [mutableData appendData:data];
    return mutableData;
}

- (id)reverseTransformedValue:(NSData*)data
{
    // If there's no key (e.g. during a data migration), don't try to transform the data
    if ([self key] == nil || data == nil) return data;
    
    // The IV was stored in the first 256bits of the data
    NSData* iv = [data subdataWithRange:NSMakeRange(0, 32 * 4)];
    // Remove the IV from the encrypted data and decrypt it
    NSMutableData* mutableData = [NSMutableData dataWithData:data];
    [mutableData replaceBytesInRange:NSMakeRange(0, 32 *4 ) withBytes:NULL length:0];
    NSData *decrypted = [mutableData AES256DecryptWithKey:[self key] Iv:iv.bytes];
    return decrypted;
}
@end