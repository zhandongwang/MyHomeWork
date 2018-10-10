//
//  TDFAdaptation.h
//  TDFAdaptationKit
//
//  Created by happyo on 2017/11/30.
//

#ifndef TDFAdaptation_h
#define TDFAdaptation_h

#define VIEWSAFEAREAINSETS(view) ({UIEdgeInsets i; if(@available(iOS 11.0, *)) {i = view.safeAreaInsets;} else {i = UIEdgeInsetsZero;} i;})

///屏幕宏
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

// 判断是否是iPhone X
#define iPhoneX     (SCREEN_WIDTH == 375.f && SCREEN_HEIGHT == 812.f)

// 状态栏高度
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (iPhoneX ? 88.f : 64.f)
// tabBar高度
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f + 34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)

#endif /* TDFAdaptation_h */
