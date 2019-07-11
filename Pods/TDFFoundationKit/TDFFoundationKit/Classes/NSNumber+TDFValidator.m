//
//  NSNumber+TDFValidator.m
//  Pods
//
//  Created by 凤梨 on 2017/6/27.
//
//

#import "NSNumber+TDFValidator.h"

@implementation NSNumber (TDFValidator)

+ (BOOL)tdf_lessThanOrEqualToTwoDecimal:(CGFloat)value {
    if ((fmodf(value, 1) == 0 || fmodf(value * 10, 1) == 0 || fmodf(value * 100, 1) == 0)) {
        return YES;
    }
    return NO;
}

@end
