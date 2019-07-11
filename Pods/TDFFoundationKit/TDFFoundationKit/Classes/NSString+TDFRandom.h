//
// Created by huanghou  on 2017/6/8.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (TDFRandom)
+ (NSString *)tdf_defaultAlphabet;

+ (id)tdf_randomizedString;

+ (id)tdf_randomizedStringWithLength:(NSUInteger)length;

+ (id)tdf_randomizedStringWithAlphabet:(NSString *)alphabet;

+ (id)tdf_randomizedStringWithAlphabet:(NSString *)alphabet length:(NSUInteger)len;

- (id)initWithDefaultAlphabet;

- (id)initWithAlphabet:(NSString *)alphabet;

- (id)initWithAlphabet:(NSString *)alphabet length:(NSUInteger)len;
@end