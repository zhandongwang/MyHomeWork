//
//  UIToolbar+TDFUIKit.m
//  TDFUIKit
//
//  Created by qingye on 2019/3/7.
//

#import "UIToolbar+TDFUIKit.h"
#import <objc/runtime.h>

static const void *kTDFToolbarBlockKey = &kTDFToolbarBlockKey;

@implementation UIToolbar (TDFUIKit)

- (void)tdf_setTitle:(NSString *)title titleColor:(UIColor *)titleColor action:(blk)action {
    [self tdf_setTitle:title titleColor:titleColor action:action tintColor:nil backgroundColor:nil];
}

- (void)tdf_setTitle:(NSString *)title titleColor:(UIColor *)titleColor action:(blk)action tintColor:(UIColor *)tintColor backgroundColor:(UIColor *)backgroundColor {
    objc_setAssociatedObject(self, kTDFToolbarBlockKey, action, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title  forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didClickToolBar) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 44, 35)];
    UIBarButtonItem *bar = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.items = @[space, bar];
    self.backgroundColor = backgroundColor;
    self.tintColor = tintColor;
}

- (void)didClickToolBar {
    blk action = objc_getAssociatedObject(self, kTDFToolbarBlockKey);
    if (action) {
        action();
    }
}

@end
