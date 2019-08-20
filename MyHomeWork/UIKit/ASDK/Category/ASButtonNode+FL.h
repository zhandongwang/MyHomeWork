//
//  ASButtonNode+FL.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/7/24.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import <AsyncDisplayKit/AsyncDisplayKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ASButtonNode (FL)

+ (ASButtonNode *)createWithText:(NSString *)text Font:(UIFont *)font Color:(UIColor *)color Image:(UIImage *)img Spacing:(CGFloat)spacing;
@end

NS_ASSUME_NONNULL_END
