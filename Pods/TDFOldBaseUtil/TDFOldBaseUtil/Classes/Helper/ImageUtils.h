//
//  ImageUtils.h
//  CardApp
//
//  Created by 邵建青 on 14-1-20.
//  Copyright (c) 2014年 ZMSOFT. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define IMAGE_URL_FORMAT @"http://%@/upload_files/%@"

#define SMALL_IMAGE_URL_FORMAT @"http://%@/upload_files/%@_s"
//w宽 h高 e(1裁剪，4等比例压缩) Q质量  x倍率
#define CAPTURE_IMAGE_URL_FORMAT @"%@/%@@%lde_%.0fw_%.0fh_1c_0i_0o_%.0fQ_%@.jpg"
@interface ImageUtils : NSObject

+ (NSString *)getImageUrl:(NSString *)server path:(NSString *)path;

+ (NSString *)getSmallImageUrl:(NSString *)server path:(NSString *)path;

+ (UIImage *)changeImageSize:(UIImage *)image size:(CGSize)size;

+ (UIImage*) scaleImage:(UIImage*)image width:(int)width height:(int)height;

+(NSString*) smallPath:(NSString*)sourcePath;

+(NSString *) originImageUrl:(NSString *)path;

+(NSString *) captureImageUrl:(NSString *)path size:(CGSize )size;

+(NSString *) scaleImageUrl:(NSString *)path size:(CGSize )size;

+(NSString *)editImageUrlWithPath:(NSString *)path
                             size:(CGSize)size
                            model:(NSInteger)model
                          quality:(float)quality
                         standard:(NSString *)standard;
@end
