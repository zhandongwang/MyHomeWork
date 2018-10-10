//
//  XHAnimalUtil.h 工具类.
//  RestApp
//
//  Created by zxh on 14-6-6.
//  Copyright (c) 2014年 杭州迪火科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHAnimalUtil : NSObject

+ (void)animal:(UIViewController *)controller type:(NSString*)type direct:(NSString*)direct;

+ (void)animalEdit:(UIViewController *)controller action:(NSInteger)action;

+ (void)animationMoveUp:(UIView *)view;

+ (void)animationMoveDown:(UIView *)view;

+ (void)animationMoveIn:(UIView *)view backround:(UIView *)background;

+ (void)animationMoveOut:(UIView *)view backround:(UIView *)background;

@end
