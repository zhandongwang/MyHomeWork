//
//  UIViewController+Helper.h
//  Pods
//
//  Created by tripleCC on 12/17/16.
//
//

#import <UIKit/UIKit.h>

#define TDF_TOP_VC [[UIApplication sharedApplication].keyWindow.rootViewController tdf_topViewController]

#define TDF_TOP_NAV_VC [[UIApplication sharedApplication].keyWindow.rootViewController tdf_topNavigationController]

@interface UIViewController (TopViewController)
/**
 从导航控制器堆栈中移除
 */
- (void)tdf_removeFromNavigationController;

/**
 当前最顶部控制器
 */
- (UIViewController *)tdf_topViewController;

- (UINavigationController *)tdf_topNavigationController;
@end
