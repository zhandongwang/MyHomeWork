//
// Created by huanghou  on 2017/4/6.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImage+TDFUIRoundCorner.h"

@interface UIButton (TDFUICorner)
/**
 *  UIButton添加圆角并设置背景图片
 *
 *  @param cornerRadius     圆角半径
 *  @param normalImage      正常情况下的背景图
 *  @param highlightedImage 高亮的背景图
 *  @param disableImage     禁用的背景图
 *  @param color            背景颜色
 */
- (void)tdf_setCornerRadius:(CGFloat)cornerRadius setNormalImage:(UIImage *)normalImage highlightedImage:(UIImage *)highlightedImage disabledImage:(UIImage *)disableImage selectedImage:(UIImage *)selectedImage backgroundColor:(UIColor *)color;
@end
