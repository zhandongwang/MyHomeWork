//
//  TDFOldNavAdapter.h
//  Pods
//
//  Created by happyo on 2017/8/28.
//
//
#import "UIViewController+NavigationBarConfigure.h"
#import <Foundation/Foundation.h>

@interface TDFCustomNavBarAdapter : NSObject

@property (nonatomic, assign, readonly) BOOL isCustom;

+ (instancetype)sharedInstance;

- (UIImage *)adapterBackgroundImageWithDefaultImage:(UIImage *)image;

- (UIColor *)adapterTitleColorWithDefaultColor:(UIColor *)color;

- (UIColor *)adapterButtonColorWithDefaultColor:(UIColor *)color;

- (UIStatusBarStyle)adpterBarStyleWithDefaultStyle:(UIStatusBarStyle)barStyle;

- (UIColor *)adapterAlphaViewColorWithDefaultColor:(UIColor *)color;

- (UIColor *)adapterNavigationBarColorWithDefaultColor:(UIColor *)color;

- (UIImage *)adapterBackArrowImageWithDefaultImage:(UIImage *)image;

- (UIImage *)adapterLeftImageWithImage:(UIImage *)image;

- (UIImage *)adapterRightImageWithImage:(UIImage *)image;

- (NSString *)adapterLeftBackTitle;

- (CGFloat)adapterAlpha;

- (NSString *)adapterCloseTitle ;

- (UIImage *)adapterCloseImage ;

- (UIColor *)adapterSearchViewCancelColor;

- (UIImage *)adapterCloseImageWithNavigationBarStyle:(TDFNavigationBarStyle)style;
//调整供应链主题风格方法
- (void)adapterGYLThemeStyleWithNavigationBarStyle:(TDFNavigationBarStyle)style;
@end

@interface UIColor (Hex)
+(UIColor *)colorWithHeX:(long)hexColor;
+(UIColor *)colorWithHeX:(long)hexColor alpha:(float)alpha;
+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;
@end
