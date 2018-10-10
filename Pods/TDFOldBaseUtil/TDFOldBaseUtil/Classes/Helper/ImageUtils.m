//
//  ImageUtils.m
//  CardApp
//
//  Created by 邵建青 on 14-1-20.
//  Copyright (c) 2014年 ZMSOFT. All rights reserved.
//k

#import "ImageUtils.h"
#import "RestConstants.h"
#import "NSString+Estimate.h"
#import "RegexKitLite.h"
@implementation ImageUtils

+ (NSString *)getImageUrl:(NSString *)server path:(NSString *)path
{
    return [NSString stringWithFormat:IMAGE_URL_FORMAT, server, path];
}

+ (NSString *)getSmallImageUrl:(NSString *)server path:(NSString *)path
{
    return [NSString stringWithFormat:SMALL_IMAGE_URL_FORMAT, server, path];
}

+ (UIImage *)changeImageSize:(UIImage *)image size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+(NSString*) smallPath:(NSString*)sourcePath
{
    if ([NSString isBlank:sourcePath]) {
        return sourcePath;
    }
    NSString* format=@"[\\?+?]ran=([^&]+)";
    return [sourcePath stringByReplacingOccurrencesOfRegex:format withString:@"_s"];
}

+(NSString *) originImageUrl:(NSString *)path{

    if ([path hasPrefix:@"http://"]) {
        NSLog(@"%@",path);
        return [NSString urlFilterRan:path];
    }
    
    return [NSString urlFilterRan:[NSString stringWithFormat:@"%@/upload_files/%@",kTDFImageOriginPath,path]];
}

+(NSString *) captureImageUrl:(NSString *)path size:(CGSize )size{
    return [ImageUtils editImageUrlWithPath:path size:size model:1 quality:80.0f standard:nil];
}

+(NSString *) scaleImageUrl:(NSString *)path size:(CGSize )size{
    return [ImageUtils editImageUrlWithPath:path size:size model:4 quality:80.0f standard:@"1x"];
}

+(NSString *)editImageUrlWithPath:(NSString *)path
                             size:(CGSize)size
                            model:(NSInteger)model
                          quality:(float)quality
                         standard:(NSString *)standard{
    if ([NSString isBlank:path]) {
        return @"";
    }
    NSString *url;
    if (![path hasPrefix:@"http://"]) {
        url = [NSString stringWithFormat:CAPTURE_IMAGE_URL_FORMAT,kTDFImageFilePath,[NSString urlFilterRan:path],(long)model,size.width, size.height,quality,[NSString isNotBlank:standard]?standard:[NSString stringWithFormat:@"%.0fx",[UIScreen mainScreen].scale]];
        return url;
    }
    path = [NSString urlFilterRan:path];
    if ([path rangeOfString:@"/upload_files/"].location != NSNotFound && [path hasPrefix:kTDFImageOriginPath]) {
        NSArray *array =  [path componentsSeparatedByString:@"/upload_files/"];
        path =  [array lastObject];
                url = [NSString stringWithFormat:CAPTURE_IMAGE_URL_FORMAT,kTDFImageFilePath,path,(long)model,size.width, size.height,quality,[NSString isNotBlank:standard]?standard:[NSString stringWithFormat:@"%.0fx",[UIScreen mainScreen].scale]];
        return url;
    }

    path = [NSString urlFilterRan:path];
    if ([path rangeOfString:@"/upload_files"].location != NSNotFound && [path hasPrefix:kTDFImageFilePath]) {
        NSArray *array =  [path componentsSeparatedByString:@"/upload_files/"];
        path =  [array lastObject];
        url = [NSString stringWithFormat:CAPTURE_IMAGE_URL_FORMAT,kTDFImageFilePath,path,(long)model,size.width, size.height,quality,[NSString isNotBlank:standard]?standard:[NSString stringWithFormat:@"%.0fx",[UIScreen mainScreen].scale]];
        return url;
    }
    
    return path;

}
+(UIImage*) scaleImage:(UIImage*)image width:(int)targetWidth height:(int)targetHeight
{
    int width=targetWidth;
    int height=targetHeight;
    float scale=[self getScaleRatio:image width:targetWidth height:targetHeight];
    if (scale<1) {
        width=image.size.width*scale;
        height=image.size.height*scale;
    }else{
        return image;
    }
    
    CGSize size = CGSizeMake(width, height);
    return [self changeImageSize:image size:size];
}

+(float) getScaleRatio:(UIImage*)image width:(int)width height:(int)height
{
    float scaleRatio=1.0;
    float originWidth=image.size.width;
    float originHeight=image.size.height;
    if (width>0 && height<=0) {
        if (originWidth>width) {
            scaleRatio=width/originWidth;
        }
    }else if(width<=0 && height>0){
        if (originHeight>height) {
            scaleRatio=height/originHeight;
        }
    }else if(width>0 && height>0){
        float widthRatio=1.0;
        float heightRatio=1.0;
        if (originWidth>width) {
            widthRatio=width/originWidth;
            scaleRatio=widthRatio;
        }
        if (originHeight>height) {
            heightRatio=height/originHeight;
            if (heightRatio<widthRatio) {
                scaleRatio=heightRatio;
            }
        }
    }
    return scaleRatio;
}


@end
