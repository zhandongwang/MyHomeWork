//
//  UIImage+TransSize.h
//  RestApp
//
//  Created by zxh on 14-7-28.
//  Copyright (c) 2014年 杭州迪火科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Resize)
- (UIImage*)transformWidth:(CGFloat)width
                    height:(CGFloat)height;

+ (instancetype)imageWithName:(NSString *)imageName width:(CGFloat)width;

+ (instancetype)imageWithName:(NSString *)imageName height:(CGFloat)height;
@end
