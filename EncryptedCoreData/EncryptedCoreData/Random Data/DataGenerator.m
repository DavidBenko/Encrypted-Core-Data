//
//  DataGenerator.m
//  Securis
//
//  Created by PRNDL1 on 10/31/13.
//  Copyright (c) 2013 PRNDL Development Studios, LLC. All rights reserved.
//

#import "DataGenerator.h"

@implementation DataGenerator
+(NSData*)createRandomDataOfLength:(int)length
{
    NSMutableData* theData = [NSMutableData dataWithCapacity:length * 4];
    for( unsigned int i = 0 ; i < length ; ++i )
    {
        u_int32_t randomBits = arc4random();
        [theData appendBytes:(void*)&randomBits length:4];
    }
    return theData;
}
+(NSString *)createRandomStringOfLength:(int)len {
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [[DataGenerator shuffleSetWithSet:ALL_CHARACTERS] characterAtIndex: arc4random_uniform(ALL_CHARACTERS_LENGTH)]];
    }
    return randomString;
}
+ (NSString *)shuffleSetWithSet:(NSString *)set {
    // Create a copy of the original set
    NSMutableString *newSet;
    newSet = [NSMutableString stringWithString:set];
    // Loop backwards through members of the set
    for (int i = ([set length] - 1); i > 0; i--) {
        /* Choose a random number (0 <= rand <= i)
         Because i constantly decreases, the number
         of elements we can swap with becomes smaller
         as we loop */
        int rand = (arc4random_uniform(i + 1));
        //Select the elements at rand and i
        NSString *lastChar = [NSString stringWithFormat:@"%c",[newSet characterAtIndex:i]];
        NSString *randChar = [NSString stringWithFormat:@"%c",[newSet characterAtIndex:rand]];
        // Swap the elements
        [newSet replaceCharactersInRange:NSMakeRange(rand, 1) withString:lastChar];
        [newSet replaceCharactersInRange:NSMakeRange(i, 1) withString:randChar];
    }
    return newSet;
}
@end
