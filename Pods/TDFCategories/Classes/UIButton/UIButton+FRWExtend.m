//
//  UIButton+FRWExtend.m
//  CardApp
//
//  Created by CaydenK on 2016/10/15.
//  Copyright © 2016年 2dfire.com. All rights reserved.
//

#import "UIButton+FRWExtend.h"
#import <objc/runtime.h>

@interface UIButton ()

@property (assign, nonatomic,setter=frw_setEdge:) UIEdgeInsets frw_edge;

@end

@implementation UIButton (FRWExtend)

void ESSwizzleInstanceMethod(Class cls, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(cls, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSelector);
    BOOL didAddMethod = class_addMethod(cls, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(cls, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
    
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ESSwizzleInstanceMethod([self class], @selector(hitTest:withEvent:), @selector(es_hitTest:withEvent:));
    });
}

- (void)setTouchEdge:(UIEdgeInsets)edge {
    self.frw_edge = edge; 
}

#pragma mark - overload
- (UIView *)es_hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if (UIEdgeInsetsEqualToEdgeInsets(self.frw_edge, UIEdgeInsetsZero)) {
        return [self es_hitTest:point withEvent:event];
    }
    
    CGRect rect = self.bounds;
    rect.origin.x -= self.frw_edge.left;
    rect.origin.y -= self.frw_edge.top;
    rect.size.width += (self.frw_edge.left + self.frw_edge.right);
    rect.size.height += (self.frw_edge.top + self.frw_edge.bottom);
    
    if (CGRectContainsPoint(rect, point)) {
        //如果作为UIView的Extend,则会导致手势无效，暂且继续用button
        CGPoint center = CGPointMake(CGRectGetWidth(self.bounds)/2.0, CGRectGetHeight(self.bounds)/2.0);
        return [self es_hitTest:center withEvent:event];
    }
    else {
        return [self es_hitTest:point withEvent:event];
    }
    
    
}

#pragma mark - get & set
- (UIEdgeInsets)frw_edge {
    return [(NSValue *)objc_getAssociatedObject(self, _cmd) UIEdgeInsetsValue];
}

- (void)frw_setEdge:(UIEdgeInsets)edge {
    NSValue *value = [NSValue valueWithUIEdgeInsets:edge];
    objc_setAssociatedObject(self, @selector(frw_edge), value, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


@end
