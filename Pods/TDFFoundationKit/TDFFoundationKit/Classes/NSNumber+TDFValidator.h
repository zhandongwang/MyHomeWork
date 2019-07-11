//
//  NSNumber+TDFValidator.h
//  Pods
//
//  Created by 凤梨 on 2017/6/27.
//
//

#import <Foundation/Foundation.h>

@interface NSNumber (TDFValidator)
//少于等于两位小数
+ (BOOL)tdf_lessThanOrEqualToTwoDecimal:(CGFloat)value;

@end
