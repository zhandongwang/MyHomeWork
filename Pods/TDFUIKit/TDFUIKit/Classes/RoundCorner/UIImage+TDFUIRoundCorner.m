//
//  UIImage+TDFUIRoundCorner.m
//  AYViewCorner
//
//  Created by Andy on 16/4/4.
//  Copyright © 2016年 AYJkdev. All rights reserved.
//

#import "UIImage+TDFUIRoundCorner.h"
#import <ImageIO/ImageIO.h>

@implementation UIImage (TDFUIRoundCorner)

+ (UIImage *)tdf_createImageWithCornerRadius:(CGFloat)cornerRadius originImage:(UIImage *)originImage backgroundColor:(UIColor *)color drawRect:(CGRect)rect {
    if (originImage) {
        return [self tdf_createImageWithCornerRadius:cornerRadius originImage:originImage backgroundColor:color drawRect:rect contentMode:UIViewContentModeScaleAspectFill];
    }
    return [self tdf_createImageWithCornerRadius:cornerRadius originImage:originImage backgroundColor:color drawRect:rect contentMode:UIViewContentModeScaleToFill];
}

+ (UIImage *)tdf_createImageWithCornerRadius:(CGFloat)cornerRadius originImage:(UIImage *)originImage backgroundColor:(UIColor *)color drawRect:(CGRect)rect contentMode:(UIViewContentMode)contentMode {
    return [self tdf_createImageWithCornerRadius:cornerRadius originImage:originImage backgroundColor:color drawRect:rect borderWidth:0 borderColor:[UIColor clearColor] contentMode:contentMode];
}

+ (UIImage *)tdf_createImageWithCornerRadius:(CGFloat)cornerRadius originImage:(UIImage *)originImage backgroundColor:(UIColor *)color  drawRect:(CGRect)rect borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor contentMode:(UIViewContentMode)contentMode {
    if (originImage) {
        originImage = [originImage scaleImageWithContentMode:contentMode containerRect:rect];
        color = [UIColor colorWithPatternImage:originImage];
    }
    CGFloat x = CGRectGetWidth(rect);
    CGFloat y = CGRectGetHeight(rect);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);//填充色
    CGContextSetLineWidth(context, borderWidth);//边框宽度
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);//边框颜色
    CGPathRef clippath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(borderWidth/2,borderWidth/2, x - borderWidth, y - borderWidth) cornerRadius:cornerRadius].CGPath;
    CGContextAddPath(context, clippath);

    CGContextDrawPath(context, kCGPathFillStroke);
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return outputImage;
}

- (UIImage *)scaleImageWithContentMode:(UIViewContentMode)contentMode containerRect:(CGRect)rect {
    //只支持PNG,JPEG
    NSData *imageData = UIImageJPEGRepresentation(self, 0.9);
    if (!imageData) {
        imageData = UIImagePNGRepresentation(self);
    }
    CGImageSourceRef imageSource = CGImageSourceCreateWithData((__bridge CFDataRef) imageData, NULL);
    NSAssert(imageSource != NULL, @"cannot create image source");

    CGRect imageRect = [self drawImageWithContentMode:contentMode containerRect:rect];
    NSDictionary *imageOptions = @{
            (NSString const *) kCGImageSourceCreateThumbnailFromImageIfAbsent: (NSNumber const *) kCFBooleanTrue,
            (NSString const *) kCGImageSourceThumbnailMaxPixelSize: @(MAX(imageRect.size.width, imageRect.size.height) * self.scale),
            (NSString const *) kCGImageSourceCreateThumbnailWithTransform: (NSNumber const *) kCFBooleanTrue
    };
    CGImageRef thumbnail = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, (__bridge CFDictionaryRef) imageOptions);
    CFRelease(imageSource);
    UIImage *scaledImage = [[UIImage alloc] initWithCGImage:thumbnail scale:self.scale orientation:UIImageOrientationUp];
    CGImageRelease(thumbnail);

    return scaledImage;
}

- (CGRect)drawImageWithContentMode:(UIViewContentMode)contentMode containerRect:(CGRect)rect {

    CGSize imageSize = self.size;
    switch (contentMode) {
        case UIViewContentModeScaleAspectFill: {
            if (rect.size.width < rect.size.height) {
                imageSize.width = imageSize.width / (imageSize.height / rect.size.height);
                imageSize.height = rect.size.height;
            } else {
                imageSize.height = imageSize.height / (imageSize.width / rect.size.width);
                imageSize.width = rect.size.width;
            }
            return CGRectMake((rect.size.width - imageSize.width) * .5, (rect.size.height - imageSize.height) * .5, imageSize.width, imageSize.height);
        }
            break;
        case UIViewContentModeScaleAspectFit: {
            if (rect.size.width < rect.size.height) {
                imageSize.height = imageSize.height / (imageSize.width / rect.size.width);
                imageSize.width = rect.size.width;
                return CGRectMake(0, (rect.size.height - imageSize.height) * .5, imageSize.width, imageSize.height);
            } else {
                imageSize.width = imageSize.width / (imageSize.height / rect.size.height);
                imageSize.height = rect.size.height;
                return CGRectMake((rect.size.width - imageSize.width) * .5, 0, imageSize.width, imageSize.height);
            }

        }
            break;
        case UIViewContentModeScaleToFill: {

            return rect;
        }
        default:
            return rect;
            break;
    }
}

@end
