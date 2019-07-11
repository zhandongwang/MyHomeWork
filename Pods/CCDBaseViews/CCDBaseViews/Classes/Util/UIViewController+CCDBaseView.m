//
// Created by huanghou  on 2017/7/20.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import <objc/runtime.h>
#import "UIViewController+CCDBaseView.h"
#import "MBProgressHUD.h"
#import "TDFBundleHelper.h"
#import "CCDBaseViewController.h"
#import "DGActivityIndicatorView.h"


@implementation UIViewController (CCDBaseView)

- (void)ccd_showLoading {
    [self ccd_showLoadingWithTitle:TDFLocalizedStringFromBundle(@"loading", [CCDBaseViewController class], @"正在加载")];
}

- (void)ccd_showLoadingWithTitle:(NSString *)title {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode                 = MBProgressHUDModeCustomView;
    hud.minSize = CGSizeMake(90, 90);
    DGActivityIndicatorView *activityIndicatorView = [[DGActivityIndicatorView alloc] initWithType:DGActivityIndicatorAnimationTypeBallClipRotate
                                                                                         tintColor:[UIColor whiteColor]];
    hud.customView           = activityIndicatorView;
    [activityIndicatorView startAnimating];
    hud.margin               = 10;
    hud.labelFont            = [UIFont systemFontOfSize:13.0];
    hud.detailsLabelFont     = [UIFont systemFontOfSize:12.0];
    hud.label.text           = title;

}

- (void)ccd_hideLoading {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
@end