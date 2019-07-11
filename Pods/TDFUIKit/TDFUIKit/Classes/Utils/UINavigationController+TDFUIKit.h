//
// Created by huanghou  on 2017/6/27.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UINavigationController (TDFUIKit)

- (void)tdf_popToViewControllerWithClassName:(NSString *)className animdated:(BOOL)animated;

#pragma mark -- remove操作最好放入主线程操作
//dispatch_async(dispatch_get_main_queue(), ^{ //removeControllers });

- (void)tdf_removeControllersWithClassName:(NSString *)className animated:(BOOL)animated;

- (void)tdf_removeControllersWithClassNames:(NSArray *)classNames animated:(BOOL)animated;

- (void)tdf_removeController:(UIViewController *)controller animated:(BOOL)animated;

- (void)tdf_removeControllers:(NSArray *)controllers animated:(BOOL)animated;
@end
