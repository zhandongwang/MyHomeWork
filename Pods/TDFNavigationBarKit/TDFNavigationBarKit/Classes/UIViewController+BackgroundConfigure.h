//
//  UIViewController+BackgroundConfigure.h
//  Pods
//
//  Created by tripleCC on 2017/8/16.
//
//

#import <UIKit/UIKit.h>

@interface UIViewController (BackgroundConfigure)

/**
 背景图
 */
@property (strong, nonatomic, readonly) UIImageView *tdf_backgroundImageView;

/**
 萌版
 */
@property (strong, nonatomic, readonly) UIView *tdf_backgroundAlphaView;

/**
 设置控制器背景
 
 会添加 背景图片，以及其上的萌版
 */
- (void)tdf_setupBackgroundField;

@end
