//
// Created by 於卓慧 on 5/27/16.
// Copyright (c) 2016 2dfire. All rights reserved.
//

#import "NSString+TDFNetworking.h"
#import <NSHash/NSString+NSHash.h>

static NSString* SIGN_KEY=@",.xcvlasdiqpoikm,. xvz";
static NSString* SENSITIVE_DATA = @"!#$%_d23499**(^";

@implementation NSString (TDFNetworking)


- (NSString *)encryptedString {

    if (self && self.length <= 0) {
        return nil;
    }

    NSString *MD5String = [self MD5];
    NSString *MD5StringWithSalt = [MD5String stringByAppendingString:SENSITIVE_DATA];
    NSString *sha256String = [MD5StringWithSalt SHA256];

    return [sha256String MD5];

}

- (BOOL)isBlank {
    return self.length == 0 || [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]].length == 0;
}

@end