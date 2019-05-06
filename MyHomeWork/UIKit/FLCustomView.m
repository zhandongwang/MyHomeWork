//
//  WZDCustomView.m
//  MyHomeWork
//
//  Created by 凤梨 on 16/12/17.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import "FLCustomView.h"

@interface FLCustomView()

@property (nonatomic, copy) NSString *name;


@end


@implementation FLCustomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}


- (void)setNeedsDisplay {
    [super setNeedsDisplay];
    NSLog(@"%s%s",__FILE__,__func__);
}

//- (void)displayLayer:(CALayer *)layer {
//    NSLog(@"%s%s",__FILE__,__func__);
//}

//- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
//    NSLog(@"%s%s",__FILE__,__func__);
//    [super drawLayer:layer inContext:ctx];
//}

- (void)drawRect:(CGRect)rect {
    NSLog(@"%s%s",__FILE__,__func__);
//    self.backgroundColor = [UIColor redColor];
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(100, 200, 100, 100)];
//    [[UIColor redColor] set];
//    [path stroke];
//
//
//    UIBezierPath *path2 = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 150, 200, 200)];
//    [[UIColor greenColor] set];
//    [path2 stroke];
    CGContextRef con = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(con, [UIColor redColor].CGColor);
    CGContextAddEllipseInRect(con, CGRectMake(100, 200, 100, 100));
    CGContextAddEllipseInRect(con, CGRectMake(50, 150, 200, 200));
    
    CGContextStrokePath(con);
    
    
}

- (void)updateName:(NSString *)name {
    self.name = name;
}

@end
