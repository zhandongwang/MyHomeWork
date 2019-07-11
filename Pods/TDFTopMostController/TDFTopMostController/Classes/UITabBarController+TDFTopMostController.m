//
//  UITabBarController+TDFTopMostController.m
//  TDFTopMostController
//
//  Created by Marian Paul on 24/05/13.
//  Copyright (c) 2013 iPuP. All rights reserved.
//

#import "UITabBarController+TDFTopMostController.h"

@implementation UITabBarController (TDFTopMostController)

- (UIViewController *)tdf_visibleViewController {
    return self.selectedViewController;
}

@end
