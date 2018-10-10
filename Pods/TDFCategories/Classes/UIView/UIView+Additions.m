//
//  UIView+Additions.m
//  JSWithOCTest
//
//  Created by 黄河 on 2017/7/7.
//  Copyright © 2017年 LearnLibrary. All rights reserved.
//

#import "UIView+Additions.h"
#import <CoreText/CoreText.h>

@implementation UIView (Additions)

- (UIImage *)imageWithBackgroundColor:(UIColor *)backgroundColor
                            drawBlcok:(void(^)(CGContextRef context))drawBlock {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [backgroundColor set];
    CGContextFillRect(context, self.bounds);
    if (drawBlock) {
        drawBlock(context);
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)drawRect:(CGRect)rect
        withText:(NSAttributedString *)attributedString
       inContext:(CGContextRef)context {
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(rect.origin.x, self.bounds.size.height - rect.size.height - rect.origin.y, rect.size.width, rect.size.height));
    
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef) attributedString);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    CTFrameDraw(frame, context);
    
    CFRelease(path);
    CFRelease(frameSetter);
    CFRelease(frame);
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);

}

@end
