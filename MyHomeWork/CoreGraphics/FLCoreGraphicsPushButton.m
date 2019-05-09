//
//  FLCoreGraphicsPushButton.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/5/6.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLCoreGraphicsPushButton.h"

static const CGFloat plusLineWidth = 3.0;
static const CGFloat plusButtonScale = 0.6;
static const CGFloat halfPointShift = 0.5;

@implementation FLCoreGraphicsPushButton

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [[UIColor blueColor] setFill];
    [path fill];
    
    CGFloat plusWidth = MIN(self.bounds.size.width, self.bounds.size.height) * plusButtonScale;
    CGFloat halfPlusWidth = plusWidth * 0.5;
    UIBezierPath *plusPath = [[UIBezierPath alloc] init];
    [plusPath setLineWidth:plusLineWidth];
    [plusPath moveToPoint:CGPointMake([self halfWidth] - halfPlusWidth, [self halfHeight])];
    [plusPath addLineToPoint:CGPointMake([self halfWidth] + halfPlusWidth, [self halfHeight])];
    
    [plusPath moveToPoint:CGPointMake([self halfWidth], [self halfHeight] - halfPlusWidth)];
    
    [plusPath addLineToPoint:CGPointMake([self halfWidth], [self halfHeight] + halfPlusWidth)];
    
    [[UIColor whiteColor] setStroke];
    [plusPath stroke];
    
    
    
    
    
    
}

- (CGFloat)halfWidth {
    return self.bounds.size.width * 0.5;
}

- (CGFloat)halfHeight {
    return self.bounds.size.height * 0.5;
}



@end
