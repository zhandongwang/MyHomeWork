//
//  UIViewController+HUD.h
//  RestApp
//
//  Created by Octree on 7/9/16.
//  Copyright © 2016年 杭州迪火科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MBProgressHUD;
@interface UIViewController (HUD)

@property (strong, nonatomic, readonly) MBProgressHUD *messageHud;

- (void)showHUBWithText:(NSString *)text;
- (void)dismissHUD;
- (void)showSuccessMessage:(NSString *)message duration:(NSTimeInterval)duration;
- (void)showErrorMessage:(NSString *)message;

@end
