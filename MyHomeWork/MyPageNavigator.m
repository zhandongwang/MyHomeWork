//
//  MyPageNavigator.m
//  MyHomeWork
//
//  Created by 王战东 on 2016/11/9.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPageNavigator.h"
#import "MyPageRouter.h"

@implementation MyPageNavigator

+ (instancetype)navigator
{
    return [self instance];
}

+ (instancetype)instance
{
    static dispatch_once_t oncePredicate;
    static MyPageNavigator *instance;
    dispatch_once(&oncePredicate, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (BOOL)pushViewControllerByUrl:(NSString *)url animated:(BOOL)animate
{
    UIViewController *viewController = [[MyPageRouter router] matchControllerUrl:url];
    if (!viewController) {
        return NO;
    }
    
    [self pushViewController:viewController animated:animate];
    return YES;
}

- (BOOL)pushViewController:(UIViewController *)viewController animated:(BOOL)animate
{
//    if (!viewController) {
//        return NO;
//    }
//    
//    if (_navigationControllerPool.count <= 0 || !_rootNavigationController) {
//        self.rootNavigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
//        return YES;
//    }
//    
//    UINavigationController *navigationController = [self.navigationControllerPool lastObject];
//    [navigationController pushViewController:viewController animated:animate];
    
    return YES;
}

@end
