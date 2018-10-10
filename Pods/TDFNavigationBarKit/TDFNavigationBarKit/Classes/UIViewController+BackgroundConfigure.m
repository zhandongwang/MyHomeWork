//
//  UIViewController+BackgroundConfigure.m
//  Pods
//
//  Created by tripleCC on 2017/8/16.
//
//
#import <objc/runtime.h>
#import "UIImage+tdf_blur.h"
#import "UIColor+RGB.h"
#import "UIViewController+BackgroundConfigure.h"
#import "UIImage+tdf_blur.h"
#import "TDFCustomNavBarAdapter.h"

static const CGFloat kTDFNavigationBarHeight = 64.0f;

@implementation UIViewController (BackgroundConfigure)
- (void)tdf_setupBackgroundField {
    
    UIImage *backgroundImage = [self backgroudImageOfApp];
//    if ([TDFCustomNavBarAdapter sharedInstance].isCustom) {
//        //供应链背景图
//        backgroundImage = [[TDFGYLThemeManager shareInstance] getBackgroundImage];
//    }else{
//        //掌柜背景图
//        backgroundImage = [[TDFThemeManager sharedInstance] getBackgroundImage];
//    }
    
    if (!backgroundImage) {
        
        self.tdf_backgroundImageView.backgroundColor = [UIColor whiteColor];
        
        return;
    }
    if ([TDFCustomNavBarAdapter sharedInstance].isCustom) {
        //供应链背景图,不需要模糊处理
        self.tdf_backgroundImageView.image = backgroundImage;
    }else{
        //掌柜背景图,有模糊处理
        self.tdf_backgroundImageView.image = [UIImage tdf_blurImage:backgroundImage withBlurNumber:0.5];
    }
}

- (id)backgroudImageOfApp {
//    NSString *appBundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    NSString *className = nil;
    SEL action = nil;
//    if ([appBundleIdentifier containsString:@"TDFSupplyChainApp"]) {
    if ([TDFCustomNavBarAdapter sharedInstance].isCustom) {
        className = @"TDFGYLThemeManager";
        action = NSSelectorFromString(@"shareInstance");
    } else {
        className = @"TDFThemeManager";
        action = NSSelectorFromString(@"sharedInstance");
    }
    Class targetClass =  NSClassFromString(className);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    id target = [targetClass performSelector:action];
#pragma clang diagnostic pop
    if (target == nil) {
        return nil;
    }
    SEL imageAction =NSSelectorFromString(@"getBackgroundImage");
    if ([target respondsToSelector:@selector(getBackgroundImage)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        target = [target performSelector:imageAction];
#pragma clang diagnostic pop
    }
    
    return target;
    
    
    
    
}

- (UIImageView *)tdf_backgroundImageView {
    if (!objc_getAssociatedObject(self, _cmd)) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = (CGRect){
            .origin = CGPointMake(0, -kTDFNavigationBarHeight),
            .size = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + kTDFNavigationBarHeight)
        };
        
        [self.view insertSubview:imageView atIndex:0];
        [self.view insertSubview:self.tdf_backgroundAlphaView aboveSubview:imageView];
        
        objc_setAssociatedObject(self, _cmd, imageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, _cmd);
}

- (UIView *)tdf_backgroundAlphaView {
    if (!objc_getAssociatedObject(self, _cmd)) {
        UIView *view = [[UIView alloc] init];
        view.frame = (CGRect){
            .origin = CGPointMake(0, -kTDFNavigationBarHeight),
            .size = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + kTDFNavigationBarHeight)
        };
        view.backgroundColor = [[UIColor tdf_colorWithRGBA:0xf9f9f9] colorWithAlphaComponent:0.9];
        
        objc_setAssociatedObject(self, _cmd, view, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return objc_getAssociatedObject(self, _cmd);
}
@end

