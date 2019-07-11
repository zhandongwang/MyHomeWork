//
//  UIImage+TDFUIRoundCorner.h
//  AYViewCorner
//
//  Created by Andy on 16/4/4.
//  Copyright © 2016年 AYJkdev. All rights reserved.
//

#import <UIKit/UIKit.h>

struct TDFUIImageRadius {
    CGFloat topLeftCornerRadius;
    CGFloat topRightCornerRadius;
    CGFloat bottomLeftCornerRadius;
    CGFloat bottomRightCornerRadius;
};
typedef struct TDFUIImageRadius TDFUIImageRadius;

static inline TDFUIImageRadius TDFUIImageRadiusMake(CGFloat topLeft, CGFloat topRight, CGFloat bottomLeft, CGFloat bottomRight) {
    TDFUIImageRadius radius;
    radius.topLeftCornerRadius = topLeft;
    radius.topRightCornerRadius = topRight;
    radius.bottomLeftCornerRadius = bottomLeft;
    radius.bottomRightCornerRadius = bottomRight;
    return radius;
}

@interface UIImage (TDFUIRoundCorner)

///无边框,有默认contentmode
+ (UIImage *)tdf_createImageWithCornerRadius:(CGFloat)cornerRadius originImage:(UIImage *)originImage backgroundColor:(UIColor *)color drawRect:(CGRect)rect;

///无边框,自定义contentmode
+ (UIImage *)tdf_createImageWithCornerRadius:(CGFloat)cornerRadius originImage:(UIImage *)originImage backgroundColor:(UIColor *)color drawRect:(CGRect)rect contentMode:(UIViewContentMode)contentMode;

/**
 完全方法:自定义边框，自定义contentmode

 @param cornerRadius 圆角半径
 @param originImage 原始图片
 @param color 图片颜色
 @param rect 图片大小
 @param borderWidth 边框宽度
 @param borderColor 边框颜色
 @param contentMode 显示模式
 @return 圆角图片
 */
+ (UIImage *)tdf_createImageWithCornerRadius:(CGFloat)cornerRadius originImage:(UIImage *)originImage backgroundColor:(UIColor *)color  drawRect:(CGRect)rect borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor contentMode:(UIViewContentMode)contentMode;

@end
