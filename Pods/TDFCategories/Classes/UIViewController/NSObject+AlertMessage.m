//
//  NSObject+AlertMessage.m
//  Pods
//
//  Created by chaiweiwei on 2017/7/3.
//
//

#import "NSObject+AlertMessage.h"
#import "UIViewController+TopViewController.h"
#import "UIViewController+AlertMessage.h"

@implementation NSObject (AlertMessage)

- (void)TDF_showAlert:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"提示", nil) message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(@"我知道了", nil) style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:action];
    
    UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController.tdf_topViewController;
    [topVC presentViewController:alertController animated:YES completion:nil];
}

- (void)TDF_showAlert:(NSString *)message alertAction:(void (^)(void))confirmBlock {
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"提示", nil) message:message preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *action = [UIAlertAction actionWithTitle:NSLocalizedString(@"我知道了", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        confirmBlock();
//    }];
//    
//    [alertController addAction:action];
    
    UIViewController *topVC = [UIApplication sharedApplication].keyWindow.rootViewController.tdf_topViewController;
    [topVC showAlert:message buttonTitle:NSLocalizedString(@"我知道了", nil) confirm:^{
        confirmBlock();
    }];
//    [topVC presentViewController:alertController animated:YES completion:nil];
}

@end
