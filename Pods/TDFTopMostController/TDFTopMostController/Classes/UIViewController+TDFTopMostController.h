//
//  UIViewController+TDFTopMostController.h
//  TDFTopMostController
//
//  Created by Marian Paul on 24/05/13.
//  Copyright (c) 2013 iPuP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDFTopMostControllerProtocol.h"

@interface UIViewController (TDFTopMostController)
/**
 This is your entry point.
 Will return the top most controller, looping through each controllers adopting the TDFTopMostControllerProtocol
 */
+ (UIViewController *)tdf_topMostController;
@end
