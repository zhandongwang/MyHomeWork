//
//  UIView+ViewCorner.m
//  AYViewCorner
//
//  Created by Andy on 16/4/3.
//  Copyright © 2016年 . All rights reserved.
//

#import "UIView+TDFUICorner.h"

@implementation UIView (TDFUICorner)

- (void)tdf_setCornerRadius:(CGFloat)cornerRadius backgroundColor:(UIColor *)color {
    [self tdf_setCornerRadius:cornerRadius backgroundImage:nil backgroundColor:color contentMode:UIViewContentModeScaleToFill];
}

- (void)tdf_setCornerRadius:(CGFloat)cornerRadius backgroundImage:(UIImage *)image {
    [self tdf_setCornerRadius:cornerRadius backgroundImage:image backgroundColor:[UIColor clearColor]  contentMode: UIViewContentModeScaleAspectFill];
}

- (void)tdf_setCornerRadius:(CGFloat)cornerRadius backgroundImage:(UIImage *)image backgroundColor:(UIColor *)color contentMode:(UIViewContentMode)contentMode {
    [self tdf_setCornerRadius:cornerRadius backgroundImage:image backgroundColor:color borderWidth:0 borderColor:[UIColor clearColor]  contentMode:contentMode];
}

- (void)tdf_setCornerRadius:(CGFloat)cornerRadius backgroundImage:(UIImage *)image backgroundColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor contentMode:(UIViewContentMode)contentMode {
    CGFloat x = CGRectGetWidth(self.frame);
    CGFloat y = CGRectGetHeight(self.frame);

    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);//填充颜色
    CGContextSetLineWidth(context, borderWidth);//边框宽度
    CGContextSetStrokeColorWithColor(context, borderColor.CGColor);//边框颜色
    
    CGPathRef clippath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(borderWidth/2,borderWidth/2, x - borderWidth, y - borderWidth) cornerRadius:cornerRadius].CGPath;
    CGContextAddPath(context, clippath);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    UIImage *currentImage =  UIGraphicsGetImageFromCurrentImageContext();//获取image
    
    if ([self isMemberOfClass:[UIView class]]) {//直接使用
        self.layer.contents = (__bridge id _Nullable)(currentImage.CGImage);
    } else if([self isMemberOfClass:[UIImageView class]]) {
        currentImage = [UIImage tdf_createImageWithCornerRadius:cornerRadius originImage:image backgroundColor:color drawRect:self.bounds borderWidth:borderWidth borderColor:borderColor contentMode:contentMode];
        ((UIImageView *)self).image = currentImage;
    } else if ([self isMemberOfClass:[UIButton class]]) {
        currentImage = [UIImage tdf_createImageWithCornerRadius:cornerRadius originImage:image backgroundColor:color drawRect:self.bounds borderWidth:borderWidth borderColor:borderColor contentMode:contentMode];
        [((UIButton *)self) setBackgroundImage:currentImage forState:UIControlStateNormal];
    } else if([self isMemberOfClass:[UILabel class]]) {//直接使用
        ((UILabel *)self).layer.backgroundColor = [UIColor colorWithPatternImage:currentImage].CGColor;
    }
    UIGraphicsEndImageContext();
}

@end
