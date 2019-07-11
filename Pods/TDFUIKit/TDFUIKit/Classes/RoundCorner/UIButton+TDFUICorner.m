//
// Created by huanghou  on 2017/4/6.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import "UIView+TDFUICorner.h"
#import "UIButton+TDFUICorner.h"


@implementation UIButton (TDFUICorner)
- (void)tdf_setCornerRadius:(CGFloat)cornerRadius setNormalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage disabledImage:(UIImage *)disableImage selectedImage:(UIImage *)selectedImage backgroundColor:(UIColor *)color {

    CGFloat viewWidth = self.frame.size.width;
    CGFloat viewHeight = self.frame.size.height;
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextSetFillColorWithColor(context, color.CGColor);
    //    起始点
    CGContextMoveToPoint(context, 0, viewHeight * .5);
    CGContextAddArcToPoint(context, 0, 0, viewWidth * .5, 0, cornerRadius);
    CGContextAddArcToPoint(context, viewWidth, 0, viewWidth, viewHeight * .5, cornerRadius);
    CGContextAddArcToPoint(context, viewWidth, viewHeight, viewWidth * .5, viewHeight, cornerRadius);
    CGContextAddArcToPoint(context, 0, viewHeight, 0, viewHeight * .5, cornerRadius);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    UIImage *currentImage = UIGraphicsGetImageFromCurrentImageContext();
    if (normalImage) {
        currentImage = [UIImage tdf_createImageWithCornerRadius:cornerRadius originImage:normalImage backgroundColor:color drawRect:self.bounds];
        
        [((UIButton *) self) setBackgroundImage:currentImage forState:UIControlStateNormal];
    }
    if (highlightedImage) {
        currentImage = [UIImage tdf_createImageWithCornerRadius:cornerRadius originImage:highlightedImage backgroundColor:color drawRect:self.bounds];
        [((UIButton *) self) setBackgroundImage:currentImage forState:UIControlStateHighlighted];
    }
    if (disableImage) {
        currentImage =  [UIImage tdf_createImageWithCornerRadius:cornerRadius originImage:disableImage backgroundColor:color drawRect:self.bounds];
        [((UIButton *) self) setBackgroundImage:currentImage forState:UIControlStateDisabled];
    }
    if (selectedImage) {
        currentImage =  [UIImage tdf_createImageWithCornerRadius:cornerRadius originImage:selectedImage backgroundColor:color drawRect:self.bounds];
        [((UIButton *) self) setBackgroundImage:currentImage forState:UIControlStateSelected];
    }
}
@end
