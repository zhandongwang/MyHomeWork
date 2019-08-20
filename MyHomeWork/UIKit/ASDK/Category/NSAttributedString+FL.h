//
//  NSAttributedString+FL.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/7/24.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (FL)

+ (NSAttributedString *)createWithText:(NSString *)text Font:(UIFont *)font Color:(UIColor *)color;

+ (NSAttributedString *)createWithText:(NSString *)text Font:(UIFont *)font Color:(UIColor *)color Alignmant:(NSTextAlignment)alignment;
@end

NS_ASSUME_NONNULL_END
