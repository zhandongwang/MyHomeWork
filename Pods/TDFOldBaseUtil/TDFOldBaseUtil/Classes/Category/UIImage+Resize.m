//
//  UIImage+TransSize.m
//  RestApp
//
//  Created by zxh on 14-7-28.
//  Copyright (c) 2014年 杭州迪火科技有限公司. All rights reserved.
//

#import "UIImage+Resize.h"

@implementation UIImage (Resize)

- (UIImage*)transformWidth:(CGFloat)width
                    height:(CGFloat)height {
    
    CGFloat destW = width;
    CGFloat destH = height;
    CGFloat sourceW = width;
    CGFloat sourceH = height;
    
    CGImageRef imageRef = self.CGImage;
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                destW,
                                                destH,
                                                CGImageGetBitsPerComponent(imageRef),
                                                4*destW,
                                                CGImageGetColorSpace(imageRef),
                                                (kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst));
    
    CGContextDrawImage(bitmap, CGRectMake(0, 0, sourceW, sourceH), imageRef);
    
    CGImageRef ref = CGBitmapContextCreateImage(bitmap);
    UIImage *resultImage = [UIImage imageWithCGImage:ref];
    CGContextRelease(bitmap);
    CGImageRelease(ref);
    
    return resultImage;
}

+ (instancetype)imageWithName:(NSString *)imageName width:(CGFloat)width {
    UIImage *image = [UIImage imageNamed:imageName];
    
    if (!image) return nil;
    
    return [UIImage imageWithCGImage:image.CGImage scale:image.size.width / width  orientation:UIImageOrientationUp];
}

+ (instancetype)imageWithName:(NSString *)imageName height:(CGFloat)height {
    UIImage *image = [UIImage imageNamed:imageName];
    
    if (!image) return nil;
    
    return [UIImage imageWithCGImage:image.CGImage scale:image.size.height / height  orientation:UIImageOrientationUp];
}


@end
