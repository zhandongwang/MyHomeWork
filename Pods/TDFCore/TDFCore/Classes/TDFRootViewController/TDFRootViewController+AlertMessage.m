//
//  TDFRootViewController+AlertMessage.m
//  RestApp
//
//  Created by happyo on 16/9/8.
//  Copyright © 2016年 杭州迪火科技有限公司. All rights reserved.
//

#import "TDFRootViewController+AlertMessage.h"

@implementation TDFRootViewController (AlertMessage)


- (void)showMessageWithTitle:(NSString *)title message:(NSString *)message cancelTitle:(NSString *)cancelTitle
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelTitle && ![cancelTitle isEqualToString:@""]) {
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
                                                              }];
        
        [alertController addAction:defaultAction];
    }
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showMessageWithTitle:(NSString *)title message:(NSString *)message msgFont:(UIFont *)font cancelTitle:(NSString *)cancelTitle {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelTitle && ![cancelTitle isEqualToString:@""]) {
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
                                                              }];
        
        [alertController addAction:defaultAction];
    }
    
    NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:message];
    [alertControllerMessageStr addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, message.length)];
    [alertController setValue:alertControllerMessageStr forKey:@"attributedMessage"];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)showMessage:(NSString *)message withDuration:(NSTimeInterval)duration
{
    [self showMessageWithTitle:message message:nil cancelTitle:nil];
    
    [self performSelector:@selector(dismissPresentViewController) withObject:nil afterDelay:duration];
}

- (void)showMessageWithTitle:(NSString *)title message:(NSString *)message cancelBlock:(void (^)())cancelBlock enterBlock:(void (^)())enterBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * action) {
                                                             if (cancelBlock) {
                                                                 cancelBlock();
                                                             }
                                                         }];
    
    [alertController addAction:cancelAction];
    
    UIAlertAction *enterAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {
                                                            if (enterBlock) {
                                                                enterBlock();
                                                            }
                                                        }];
    
    [alertController addAction:enterAction];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)dismissPresentViewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
