//
//  NSDecimalNumber+TDFCompare.h
//  Pods
//
//  Created by 凤梨 on 2017/8/31.
//
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber (TDFCompare)

- (BOOL)tdf_greaterThan:(NSDecimalNumber *)number;

- (BOOL)tdf_greaterThanOrEqualTo:(NSDecimalNumber *)number;

- (BOOL)tdf_lessThan:(NSDecimalNumber *)number;

- (BOOL)tdf_lessThanOrEqualTo:(NSDecimalNumber *)number;

- (BOOL)tdf_equalTo:(NSDecimalNumber *)number;

/**
 负数
 */
- (BOOL)tdf_isNegative;

/**
 正数
 */
- (BOOL)tdf_isPositive;

@end
