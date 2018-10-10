//
//  UINavigationController+RightGestureBack.h
//  TDFCore
//
//  Created by chaiweiwei on 2018/4/26.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (RightGestureBack)<UIGestureRecognizerDelegate>
@end

@interface UIViewController (RightGestureBack)
@property (assign, nonatomic) BOOL tdf_forceEnablePopGesture;
@end
