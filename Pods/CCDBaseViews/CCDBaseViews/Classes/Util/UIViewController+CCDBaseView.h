//
// Created by huanghou  on 2017/7/20.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MBProgressHUD;

@interface UIViewController (CCDBaseView)
- (void)ccd_showLoading;

- (void)ccd_showLoadingWithTitle:(NSString *)title;

- (void)ccd_hideLoading;

@end