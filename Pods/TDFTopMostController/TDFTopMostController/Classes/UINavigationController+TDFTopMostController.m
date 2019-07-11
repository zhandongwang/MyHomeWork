//
//  UINavigationController+TDFTopMostController.m
//  TDFTopMostController
//
//  Created by Marian Paul on 24/05/13.
//  Copyright (c) 2013 iPuP. All rights reserved.
//

#import "UINavigationController+TDFTopMostController.h"

@implementation UINavigationController (TDFTopMostController)

- (UIViewController *)tdf_visibleViewController {
    return self.topViewController;
}

@end
