//
//  FLCTView.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/4/30.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLCTView.h"
#import <CoreText/CoreText.h>

@implementation FLCTView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //2.旋转坐坐标系(默认和UIKit坐标是相反的)
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //3.创建绘制局域
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(100, 200, 100, 100));
    CGPathAddEllipseInRect(path, NULL, CGRectMake(50, 150, 200, 200));

//    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
//    CGContextAddEllipseInRect(context, CGRectMake(100, 200, 100, 100));
//    CGContextAddEllipseInRect(context, CGRectMake(50, 150, 200, 200));
//
//    CGContextStrokePath(context);
//    CGPathRef path = CGContextCopyPath(context);
    

    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:
                                     @"CoreText是用于处理文字和字体的底层技术。"
                                     "它直接和Core Graphics(又被称为Quartz)打交道。"
                                     "Quartz是一个2D图形渲染引擎，能够处理OSX和iOS中图形显示问题。"
                                     "Quartz能够直接处理字体（font）和字形（glyphs），将文字渲染到界面上，它是基础库中唯一能够处理字形的模块。"
                                     "因此CoreText为了排版，需要将显示的文字内容、位置、字体、字形直接传递给Quartz。"
                                     "与其他UI组件相比，由于CoreText直接和Quartz来交互，所以它具有更高效的排版功能。"];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, [attString length]), path, NULL);
        
    //5.开始绘制
    CTFrameDraw(frame, context);
    
    //6.释放资源
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
    
}


@end
