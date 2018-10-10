//
//  UINavigationController+RightGestureBack.m
//  TDFCore
//
//  Created by chaiweiwei on 2018/4/26.
//
#import <objc/runtime.h>
#import "UINavigationController+RightGestureBack.h"

@implementation UINavigationController (RightGestureBack)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method viewDidLoadMethod = class_getInstanceMethod(self, @selector(viewDidLoad));
        Method transitionPanGestureDidLoadMethod = class_getInstanceMethod(self, @selector(tdf_navViewDidLoad));
        
        method_exchangeImplementations(viewDidLoadMethod, transitionPanGestureDidLoadMethod);
    });
}

- (void)tdf_navViewDidLoad {
    if(![self isKindOfClass:[UINavigationController class]]) {
        return;
    }
    [self tdf_navViewDidLoad];
    self.interactivePopGestureRecognizer.delegate = self;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //只有导航的根控制器不需要右滑的返回的功能。
    if (self.viewControllers.count <= 1)
    {
        return NO;
    }
    //判断是否是表单页面的 编辑状态
    //用TDFNavigationBarTypeSaved状态不够 有的页面是直接用 [self configLeftNavigationBar:<#(NSString *)#> leftButtonName:<#(NSString *)#>] 方法赋值的
    if(!self.topViewController.tdf_forceEnablePopGesture && self.topViewController.navigationItem.rightBarButtonItem) {
        return NO;
    }
    return YES;
}

@end

@implementation UIViewController (RightGestureBack)

- (void)setTdf_forceEnablePopGesture:(BOOL)enabled {
    objc_setAssociatedObject(self, @selector(tdf_forceEnablePopGesture), @(enabled), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)tdf_forceEnablePopGesture {
    NSNumber *number = objc_getAssociatedObject(self, _cmd);
    if (!number) {
        return NO;
    }
    
    return [number boolValue];
}
@end
