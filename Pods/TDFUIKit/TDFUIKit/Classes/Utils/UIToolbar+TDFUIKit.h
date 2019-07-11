//
//  UIToolbar+TDFUIKit.h
//  TDFUIKit
//
//  Created by qingye on 2019/3/7.
//
#import <UIKit/UIKit.h>

typedef void(^blk)(void);

@interface UIToolbar (TDFUIKit)

- (void)tdf_setTitle:(NSString *)title titleColor:(UIColor *)titleColor action:(blk)action;
- (void)tdf_setTitle:(NSString *)title titleColor:(UIColor *)titleColor action:(blk)action tintColor:(UIColor *)tintColor backgroundColor:(UIColor *)backgroundColor;

@end
