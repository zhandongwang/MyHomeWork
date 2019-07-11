//
// Created by huanghou  on 2017/6/8.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import "NSString+TDFRandom.h"
#include <stdlib.h>

#define DEFAULT_LENGTH  8


@implementation NSString (TDFRandom)
+ (NSString *)tdf_defaultAlphabet {
    return @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXZY0123456789";
}

+ (id)tdf_randomizedString {
    return [self tdf_randomizedStringWithAlphabet:[self tdf_defaultAlphabet]];
}

+ (id)tdf_randomizedStringWithAlphabet:(NSString *)alphabet {
    return [self tdf_randomizedStringWithAlphabet:alphabet length:DEFAULT_LENGTH];
}

+ (id)tdf_randomizedStringWithLength:(NSUInteger)length {
    return [self tdf_randomizedStringWithAlphabet:[self tdf_defaultAlphabet] length:length];
}

+ (id)tdf_randomizedStringWithAlphabet:(NSString *)alphabet
                                length:(NSUInteger)len {
    return [[self alloc] initWithAlphabet:alphabet length:len];
}

- (id)initWithDefaultAlphabet {
    return [self initWithAlphabet:[NSString tdf_defaultAlphabet]];
}

- (id)initWithAlphabet:(NSString *)alphabet {
    return [self initWithAlphabet:alphabet length:DEFAULT_LENGTH];
}

- (id)initWithAlphabet:(NSString *)alphabet
                length:(NSUInteger)len {
    NSMutableString *s = [NSMutableString stringWithCapacity:len];
    for (NSUInteger i = 0U; i < len; i++) {
        u_int32_t r = arc4random() % [alphabet length];
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    return [self initWithString:s];
}

@end