//
// Created by huanghou  on 2017/5/11.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import "UIView+TDFFrame.h"


@implementation UIView (TDFFrame)
- (CGFloat)tdf_left {
    return self.frame.origin.x;
}



- (void)setTdf_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)tdf_top {
    return self.frame.origin.y;
}

- (void)setTdf_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)tdf_right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setTdf_right:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)tdf_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setTdf_bottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)tdf_centerX {
    return self.center.x;
}

- (void)setTdf_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)tdf_centerY {
    return self.center.y;
}

- (void)setTdf_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)tdf_width {
    return self.frame.size.width;
}

- (void)setTdf_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)tdf_height {
    return self.frame.size.height;
}

- (void)setTdf_height:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)tdf_origin {
    return self.frame.origin;
}

- (void)setTdf_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)tdf_size {
    return self.frame.size;
}

- (void)setTdf_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end