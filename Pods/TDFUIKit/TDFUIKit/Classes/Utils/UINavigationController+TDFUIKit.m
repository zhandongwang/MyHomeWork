//
// Created by huanghou  on 2017/6/27.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import "UINavigationController+TDFUIKit.h"


@implementation UINavigationController (TDFUIKit)
- (void)tdf_popToViewControllerWithClassName:(NSString *)className animdated:(BOOL)animated {
    Class toPopViewControllerClass = NSClassFromString(className);
    if (!toPopViewControllerClass){
        return;
    }
    __block UIViewController *popToViewController = nil;
    [self.viewControllers enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIViewController *viewController, NSUInteger idx, BOOL *stop) {
        if ([viewController isKindOfClass:toPopViewControllerClass]){
           popToViewController = viewController;
            *stop = YES;
        }
    }];
    if (popToViewController){
        [self popToViewController:popToViewController animated:animated];
    }
}


- (void)tdf_removeController:(UIViewController *)controller animated:(BOOL)animated {
    if (!controller) {
        return;
    }
    [self tdf_removeControllers:@[controller] animated:animated];
}

- (void)tdf_removeControllers:(NSArray *)controllers animated:(BOOL)animated {
    if (!controllers.count) {
        return;
    }
    NSMutableArray *remainControllers = [[NSMutableArray alloc] init];
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController *controller, NSUInteger idx, BOOL *stop) {
        if (![controllers containsObject:controller]) {
            [remainControllers addObject:controller];
        }
    }];
    [self setViewControllers:remainControllers animated:animated];
}

- (void)tdf_removeControllersWithClassName:(NSString *)className animated:(BOOL)animated {
    if (!className) {
        return;
    }
    [self tdf_removeControllersWithClassNames:@[className] animated:animated];
}

- (void)tdf_removeControllersWithClassNames:(NSArray *)classNames animated:(BOOL)animated {
    if (!classNames.count) {
        return;
    }
    NSMutableSet   *removedClasses         = [[NSMutableSet alloc] init];
    [classNames enumerateObjectsUsingBlock:^(NSString *className, NSUInteger idx, BOOL *stop) {
        Class removedClass = NSClassFromString(className);
        if (removedClass) {
            [removedClasses addObject:removedClass];
        }
    }];
    NSMutableArray *existedViewControllers = [[NSMutableArray alloc] init];
    [self.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController *viewController, NSUInteger idx, BOOL *stop) {
        if (![removedClasses containsObject:viewController.class]) {
            [existedViewControllers addObject:viewController];
        }
    }];
    [self setViewControllers:existedViewControllers animated:animated];
}

@end