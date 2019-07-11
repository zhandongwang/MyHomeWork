//
//  NSDecimalNumber+TDFCompare.m
//  Pods
//
//  Created by 凤梨 on 2017/8/31.
//
//

#import "NSDecimalNumber+TDFCompare.h"

@implementation NSDecimalNumber (TDFCompare)

- (BOOL)tdf_greaterThan:(NSDecimalNumber *)number {
    return [self compare:number] == NSOrderedDescending;
}

- (BOOL)tdf_greaterThanOrEqualTo:(NSDecimalNumber *)number {
    return [self compare:number] == NSOrderedDescending || [self compare:number] == NSOrderedSame;
}

- (BOOL)tdf_lessThan:(NSDecimalNumber *)number {
    return [self compare:number] == NSOrderedAscending;
}

- (BOOL)tdf_lessThanOrEqualTo:(NSDecimalNumber *)number {
    return [self compare:number] == NSOrderedAscending || [self compare:number] == NSOrderedSame;
}

- (BOOL)tdf_equalTo:(NSDecimalNumber *)number {
    return [self compare:number] == NSOrderedSame;
}

- (BOOL)tdf_isNegative {
    return [self tdf_lessThan:[NSDecimalNumber zero]];
}

- (BOOL)tdf_isPositive {
    return [self tdf_greaterThan:[NSDecimalNumber zero]];
}


@end
