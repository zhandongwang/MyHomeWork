//
//  UIAlertView+HBExtend.h
//  weather
//
//  Created by CaydenK on 2017/3/14.
//  Copyright © 2017年 CaydenK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (HBExtend)

+ (UIAlertView*)hb_showAlertViewWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles handler:(void (^)(UIAlertView *alertView, NSInteger buttonIndex))block;

@end
