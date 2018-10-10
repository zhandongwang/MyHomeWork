//
//  HBFileManager.m
//  weather
//
//  Created by CaydenK on 2016/11/28.
//  Copyright © 2016年 CaydenK. All rights reserved.
//

#import "HBFileManager.h"
#import <CommonCrypto/CommonCrypto.h>
#import "HBWebEngine.h"

static NSString * const kHBResourceName = @"HybridResource.bundle";

@implementation HBFileManager

/**
 获取字符串md5
 */
+ (NSString *)md5WithString:(NSString *)orginString {
    const char *fooData = [orginString UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(fooData, (CC_LONG)strlen(fooData), result);
    NSMutableString *saveResult = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [saveResult appendFormat:@"%02x", result[i]];
    }
    return saveResult;
}

+ (NSString *)documentPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}

+ (NSString *)boudlePath {
    NSString *path = [[self documentPath] stringByAppendingFormat:@"/%@",kHBResourceName];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return  path;
}

+ (unsigned long long)bundleSize {
    dispatch_queue_t queue = dispatch_queue_create("com.2dfire.cardapp.hybridkit.queue", DISPATCH_QUEUE_SERIAL);
    __block unsigned long long size;
    dispatch_sync(queue, ^{
        NSString *filePath = [HBFileManager boudlePath];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        size = [attrs fileSize];
    });
    return size;
}

+ (void)copyResourceToDocument {
    if ([[NSFileManager defaultManager] fileExistsAtPath:[self boudlePath]]) { return; } //document有资源包，则不操作
    NSString *pathInMainBundle = [[NSBundle mainBundle] pathForResource:kHBResourceName ofType:nil];

    if (pathInMainBundle == nil) { return; } // 若安装包中没有资源文件，则什么都不做
    [[NSFileManager defaultManager] copyItemAtPath:pathInMainBundle toPath:[self boudlePath] error:NULL];
}
/**
 删除Document中的资源包
 */
+ (void)removeDocumentBundle {
    [[NSFileManager defaultManager] removeItemAtPath:[self boudlePath] error:NULL];
}

/**
 具体文件路径

 @param url 资源地址
 @return 缓存文件全路径
 */
+ (NSString *)filePathWithURL:(NSURL *)url {
    NSString *host = url.host;
    NSString *relativePath = url.path;
    NSString *query = url.query;
    
    if (!relativePath) { return nil; }
    NSString *path = nil;
    if ([relativePath hasPrefix:@"/"]) {
        path = [[self boudlePath] stringByAppendingFormat:@"/%@%@",host,relativePath];
    }
    else {
        path = [[self boudlePath] stringByAppendingFormat:@"/%@/%@",host,relativePath];
    }
    
    if (query.length) {
        path = [path stringByAppendingFormat:@".%@",[self md5WithString:query]];
    }
    
    return  path;

}

/**
 文件路径URL

 @param url 资源地址
 @return 缓存文件URL
 */
+ (NSURL *)fileURLWithURL:(NSURL *)url {
    NSURL *fileURL = [NSURL fileURLWithPath:[self filePathWithURL:url]];
    return fileURL;
}

+ (BOOL)needCacheWithURL:(NSURL *)url {
    if ([[HBWebEngine withoutSource] containsObject:url.lastPathComponent]) {
        return NO;
    }
    return [[HBWebEngine enabledTypes] containsObject:url.pathExtension];
}

/**
 判断文件本地是否存在

 @param url 资源地址
 @return 是否存在
 */
+ (BOOL)fileExistWithURL:(NSURL *)url {
    NSString *localFilePath = [self filePathWithURL:url];
    return [[NSFileManager defaultManager] fileExistsAtPath:localFilePath];
}

/**
 保存数据到文件

 @param data 文件数据
 @param url 资源地址
 */
+ (void)fileSaveData:(NSData *)data withURL:(NSURL *)url {
    NSString *filePath = [self filePathWithURL:url];
    if ([self fileExistWithURL:url]) {
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
    else {
        //创建文件夹
        [[NSFileManager defaultManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
    }
    [[NSFileManager defaultManager] createFileAtPath:filePath contents:data attributes:nil];
}

@end
