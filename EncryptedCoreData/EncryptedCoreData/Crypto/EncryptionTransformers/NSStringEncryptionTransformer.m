//
//  NSStringEncryptionTransformer.m
//  Securis
//
//  Created by PRNDL1 on 11/13/13.
//  Copyright (c) 2013 PRNDL Development Studios, LLC. All rights reserved.
//

#import "NSStringEncryptionTransformer.h"

@implementation NSStringEncryptionTransformer
+ (Class)transformedValueClass
{
    return [NSString class];
}

- (id)transformedValue:(NSString*)string
{
    NSLog(@"------------------------");
    NSLog(@"Starting Encryption");
    NSLog(@"Original Attribute: %@",string);
    NSData* data = [string dataUsingEncoding:NSASCIIStringEncoding];
    NSData* encryptedData = [super transformedValue:data];
    NSLog(@"Encrypted Attribute: %@", encryptedData);
    NSLog(@"------------------------");
    return encryptedData;
}

- (id)reverseTransformedValue:(NSData*)data
{
    if (nil == data)return nil;
    NSLog(@"------------------------");
    NSLog(@"Starting Decryption");
    NSLog(@"Encrypted Attribute: %@",data);
    data = [super reverseTransformedValue:data];
    NSString * final = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSLog(@"Decrypted Attribute: %@",final);
    NSLog(@"------------------------");
    return final;
}
@end
