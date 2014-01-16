//
//  DataGenerator.h
//  Securis
//
//  Created by PRNDL1 on 10/31/13.
//  Copyright (c) 2013 PRNDL Development Studios, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#define ALL_CHARACTERS @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()-_+={}[]|\\\":;<>?/,.~`'"
#define ALL_CHARACTERS_LENGTH [ALL_CHARACTERS length]

@interface DataGenerator : NSObject
+(NSString *)createRandomStringOfLength:(int)len;
+(NSData*)createRandomDataOfLength:(size_t)length;
@end
