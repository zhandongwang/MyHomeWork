//
//  UIView+ViewCorner.h
//  AYViewCorner
//
//  Created by Andy on 16/4/3.
//  Copyright © 2016年 AYJkdev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+TDFUIRoundCorner.h"

@interface UIView (TDFUICorner)

///无边框, UIViewContentModeScaleToFill
- (void)tdf_setCornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)color;

///无边框, UIViewContentModeScaleAspectFill
- (void)tdf_setCornerRadius:(CGFloat)cornerRadius backgroundImage:(UIImage *)image;

///无边框，自定义contentMode
- (void)tdf_setCornerRadius:(CGFloat)cornerRadius backgroundImage:(UIImage *)image backgroundColor:(UIColor *)color contentMode:(UIViewContentMode)contentMode;


/**
 完全方法:自定义边框,contentMode

 @param cornerRadius 圆角半径
 @param image 背景图片
 @param color 背景颜色
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @param contentMode 图片绘制模式
 */
- (void)tdf_setCornerRadius:(CGFloat)cornerRadius backgroundImage:(UIImage *)image backgroundColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor contentMode:(UIViewContentMode)contentMode;


@end
