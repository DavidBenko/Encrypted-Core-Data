//
//  DataGenerator.m
//  Securis
//
//  Created by PRNDL1 on 10/31/13.
//  Copyright (c) 2013 PRNDL Development Studios, LLC. All rights reserved.
//

#import "DataGenerator.h"

@implementation DataGenerator
+ (NSData *)createRandomDataOfLength:(size_t)length {
    NSMutableData *data = [NSMutableData dataWithLength:length];
    
    int result __unused = SecRandomCopyBytes(kSecRandomDefault,
                                    length,
                                    data.mutableBytes);
    NSAssert(result == 0, @"Unable to generate random bytes: %d",
             errno);
    
    return data;
}
+(NSString *)createRandomStringOfLength:(int)len {
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [[DataGenerator shuffleSetWithSet:ALL_CHARACTERS] characterAtIndex: arc4random_uniform((int)ALL_CHARACTERS_LENGTH)]];
    }
    return randomString;
}
+ (NSString *)shuffleSetWithSet:(NSString *)set {
    // Create a copy of the original set
    NSMutableString *newSet;
    newSet = [NSMutableString stringWithString:set];
    // Loop backwards through members of the set
    for (int i = ((int)[set length] - 1); i > 0; i--) {
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
