//
//  EncryptionTransformer.h
//  Securis
//
//  Created by PRNDL1 on 10/31/13.
//  Copyright (c) 2013 PRNDL Development Studios, LLC. All rights reserved.
//

#import "NSData+AES256.h"
#include <stdlib.h>
#import "KeychainItemWrapper.h"
#import "DataGenerator.h"

@interface EncryptionTransformer : NSValueTransformer

/**
 * Returns the key used for encrypting / decrypting values during transformation.
 */
- (NSString*)key;

@end