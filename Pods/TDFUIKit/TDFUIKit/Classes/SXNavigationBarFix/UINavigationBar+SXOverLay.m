//
//  UINavigationBar+SXOverLay.m
//
//  Created by 凤梨 on 2018/8/2.
//

#import "UINavigationBar+SXOverLay.h"
#import <objc/runtime.h>

@implementation UINavigationBar (SXOverLay)

- (UIView *)overlayView {
    return objc_getAssociatedObject(self, @selector(overlayView));
}

- (void)setOverlayView:(UIView *)overlayView {
     objc_setAssociatedObject(self, @selector(overlayView), overlayView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)sx_setBackgroundColor:(UIColor *)backgroundColor {
    if (!self.overlayView) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        
        UIView *backgroundView = [self sx_getBackgroundView];
        
        self.overlayView = [[UIView alloc] initWithFrame:backgroundView.bounds];
        self.overlayView.userInteractionEnabled = NO;
        self.overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        [backgroundView insertSubview:self.overlayView atIndex:0];
    }
    self.overlayView.backgroundColor = backgroundColor;
}

- (UIView*)sx_getBackgroundView {
    if ([ [[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        UIView *_UIBackground = nil;
        NSString *targetName = @"_UIBarBackground";
        Class _UIBarBackgroundClass = NSClassFromString(targetName);
        
        for (UIView *subview in self.subviews) {
            if ([subview isKindOfClass:_UIBarBackgroundClass.class]) {
                _UIBackground = subview;
                break;
            }
        }
        return _UIBackground;
    } else {
        UIView *_UINavigationBarBackground = nil;
        NSString *targetName = @"_UINavigationBarBackground";
        Class _UINavigationBarBackgroundClass = NSClassFromString(targetName);
        
        for (UIView *subview in self.subviews) {
            if ([subview isKindOfClass:_UINavigationBarBackgroundClass.class]) {
                _UINavigationBarBackground = subview;
                break;
            }
        }
        return _UINavigationBarBackground;
    }
}

- (void)sx_hideShadowImage:(BOOL)hidden {
    UIView *bgView = [self sx_getBackgroundView];
    //shadowImage应该是只占一个像素，即1.0/scale
    for (UIView *subview in bgView.subviews) {
        if (CGRectGetHeight(subview.bounds) <= 1.0) {
            subview.hidden = hidden;
        }
    }
}

@end
