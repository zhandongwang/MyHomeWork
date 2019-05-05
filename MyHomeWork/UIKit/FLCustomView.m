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
//}

- (void)drawRect:(CGRect)rect {
    NSLog(@"%s%s",__FILE__,__func__);
    self.backgroundColor = [UIColor redColor];
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
    [[UIColor blueColor] setFill];
    [path fill];
    
}

- (void)updateName:(NSString *)name {
    self.name = name;
}

@end
