//
// Created by huanghou  on 2017/4/13.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIImage (TDFBundle)
+ (UIImage *)tdf_imageNamed:(NSString *)imageName;

+ (UIImage *)tdf_imageNamed:(NSString *)imageName inBundle:(NSBundle *)bundle;
@end
