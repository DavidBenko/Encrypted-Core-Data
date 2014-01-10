//
//  NSString+Hash.h
//  Securis
//
//  Created by PRNDL1 on 10/15/13.
//  Copyright (c) 2013 PRNDL Development Studios, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (Hash)
- (NSString *)md5HexDigest;
- (NSString *)sha1Digest;
- (NSString *)sha256Digest;
@end
