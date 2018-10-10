//
//  UIView+Additions.h
//  JSWithOCTest
//
//  Created by 黄河 on 2017/7/7.
//  Copyright © 2017年 LearnLibrary. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Additions)

- (UIImage *)imageWithBackgroundColor:(UIColor *)backgroundColor
                            drawBlcok:(void(^)(CGContextRef context))drawBlock;

- (void)drawRect:(CGRect)rect
        withText:(NSAttributedString *)attributedString
       inContext:(CGContextRef)context;

@end
