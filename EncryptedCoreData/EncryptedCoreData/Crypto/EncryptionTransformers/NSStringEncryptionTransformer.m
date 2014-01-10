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
    NSData* data = [string dataUsingEncoding:NSASCIIStringEncoding];
    return [super transformedValue:data];
}

- (id)reverseTransformedValue:(NSData*)data
{
    if (nil == data)
    {
        return nil;
    }
    
    data = [super reverseTransformedValue:data];
    NSString * final = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    
    return final;
}
@end
