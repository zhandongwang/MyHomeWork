//
//  WZDCustomView.m
//  MyHomeWork
//
//  Created by 凤梨 on 16/12/17.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import "WZDCustomView.h"

@implementation WZDCustomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
    
- (void)drawRect:(CGRect)rect {
    
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
//    [[UIColor blueColor] setFill];
//    [path fill];
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
//    CGContextSetLineWidth(context, 3);
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:myrect cornerRadius:10];
//    [path stroke];
    
//    CGContextAddEllipseInRect(context, myrect);
//    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
//    CGContextFillPath(context);
    
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
//    [[UIColor blueColor] setFill];
//    [path fill];
//    
    CGSize size = self.bounds.size;
//
//    CGFloat lineHeight = 3.0;
//    CGFloat lineWidth = 60;
//    UIBezierPath *linePath = [UIBezierPath bezierPath];
//    linePath.lineWidth = lineHeight;
//    [linePath moveToPoint:CGPointMake(size.width/2 - lineWidth/2, size.height/2)];
//    [linePath addLineToPoint:CGPointMake(size.width/2 + lineWidth/2, size.height/2)];
//    
//    [linePath moveToPoint:CGPointMake(size.width/2 ,size.height/2 - lineWidth/2)];
//    [linePath addLineToPoint:CGPointMake( size.width/2, size.height/2 + lineWidth/2)];
//    
//    [[UIColor whiteColor] setStroke];
//    [linePath stroke];
    
//    CGPoint center = CGPointMake(100, 100);
//    CGFloat radius = 100;
//    CGFloat arcWidth = 30;
//    
//    CGFloat startAngle = 3* M_PI / 4;
//    CGFloat endAngle = M_PI / 4;
//    
//    UIBezierPath *arcPath = [UIBezierPath bezierPathWithArcCenter:center radius:(radius / 2 - arcWidth / 2)startAngle:startAngle endAngle:endAngle clockwise:YES];
//    
//    arcPath.lineWidth = arcWidth;
//    [[UIColor redColor] setStroke];
//    [arcPath stroke];
//    
    
}


@end
