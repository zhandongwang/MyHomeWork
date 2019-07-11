//
//  CCDSimpleTip.h
//  Pods
//
//  Created by 凤梨 on 17/2/21.
//
//

#import <Foundation/Foundation.h>

@interface CCDSimpleTip : NSObject

+ (instancetype)sharedInstance;

+ (void)showSimpleToast:(NSString *)title inKeyWindow:(BOOL)inKeyWindow;

+ (void)showSimpleToast:(NSString *)title;

+ (void)showSimpleToast:(NSString *)title duration:(NSTimeInterval)duration;

+ (void)showSimpleToast:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset;

+ (void)showSimpleToast:(NSString *)title duration:(NSTimeInterval)duration yOffset:(CGFloat)yOffset inKeyWindow:(BOOL)inKeyWindow;
/**
 * 显示
 */
+ (void)showActivityIndicator;

+ (void)showActivityIndicatorWithSubTitle:(NSString *)subTitle;

+ (void)showActivityIndicator:(NSString *)title subTitle:(NSString *)subTitle;

+ (void)showActivityIndicator:(NSString *)title subTitle:(NSString *)subTitle inView:(UIView *)view;

+ (void)hideActivityIndicator;

+ (void)hideActivityIndicatorForView:(UIView *)view;

+ (void)showSimpleToastMethod:(NSString *)title isCenter:(BOOL)isCenter;
@end
