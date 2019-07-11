//
//  UIViewController+TDFTopMostController.m
//  TDFTopMostController
//
//  Created by Marian Paul on 24/05/13.
//  Copyright (c) 2013 iPuP. All rights reserved.
//

#import "UIViewController+TDFTopMostController.h"
#import "UINavigationController+TDFTopMostController.h"
#import "UITabBarController+TDFTopMostController.h"

@implementation UIViewController (TDFTopMostController)

+ (UIViewController *)getModalViewControllerOfControllerIfExists:(UIViewController *)controller {
    BOOL isPresenting = NO;
    do {
        // this path is called only on iOS 6+, so -presentedViewController is fine here.
        UIViewController *presented = [controller presentedViewController];
        isPresenting = presented != nil;
        if (presented != nil) {
            controller = presented;
        }
    } while (isPresenting);
    return controller;
}

+ (UIViewController *)tdf_topMostController {
    // Start with the window rootViewController
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                break;
            }
        }
    }
    UIViewController *topController = window.rootViewController;

    // Is there any modal view on top?
    topController = [self getModalViewControllerOfControllerIfExists:topController];

    // Keep reference to the old controller while looping
    UIViewController *oldTopController = nil;

    // Loop them all
    while ([topController conformsToProtocol:@protocol(TDFTopMostControllerProtocol)] && oldTopController != topController) {
        oldTopController = topController;
        topController = [(UIViewController <TDFTopMostControllerProtocol> *) topController tdf_visibleViewController];
        // Again, check for any modal controller
        topController = [self getModalViewControllerOfControllerIfExists:topController];
    }

    return topController;
}

@end
