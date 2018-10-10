//
//  UIImage+tdf_blur.h
//  TDFCategories
//
//  Created by happyo on 2017/8/15.
//  Copyright © 2017年 tripleCC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (tdf_blur)

+ (UIImage *)tdf_blurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;
+ (UIImage *)tdf_imageWithColor:(UIColor *)color;
@end
