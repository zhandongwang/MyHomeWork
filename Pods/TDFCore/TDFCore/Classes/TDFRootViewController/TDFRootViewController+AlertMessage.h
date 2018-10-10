//
//  TDFRootViewController+AlertMessage.h
//  RestApp
//
//  Created by happyo on 16/9/8.
//  Copyright © 2016年 杭州迪火科技有限公司. All rights reserved.
//

#import "TDFRootViewController.h"

@interface TDFRootViewController (AlertMessage)

- (void)showMessageWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle;

- (void)showMessageWithTitle:(NSString *)title message:(NSString *)message msgFont:(UIFont *)font cancelTitle:(NSString *)cancelTitle;

- (void)showMessage:(NSString *)message withDuration:(NSTimeInterval)duration;

- (void)showMessageWithTitle:(NSString *)title message:(NSString *)message cancelBlock:(void (^)())cancelBlock enterBlock:(void (^)())enterBlock;

@end
