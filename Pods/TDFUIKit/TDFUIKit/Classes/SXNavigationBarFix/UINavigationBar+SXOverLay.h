//
//  UINavigationBar+SXOverLay.h
//
//  Created by 凤梨 on 2018/8/2.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (SXOverLay)

@property (nonatomic ,strong) UIView *overlayView;

- (void)sx_setBackgroundColor:(UIColor *)backgroundColor;

- (void)sx_hideShadowImage:(BOOL)hidden;
@end
