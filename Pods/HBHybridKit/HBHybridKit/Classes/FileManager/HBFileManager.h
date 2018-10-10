//
//  HBFileManager.h
//  weather
//
//  Created by CaydenK on 2016/11/28.
//  Copyright © 2016年 CaydenK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBFileManager : NSObject

/**
 拷贝资源包到document
 */
+ (void)copyResourceToDocument;

/**
 删除Document中的资源包
 */
+ (void)removeDocumentBundle;
/**
 缓存bundle大小
 */
+ (unsigned long long)bundleSize;

/**
 具体文件路径
 
 @param url 资源地址
 @return 缓存文件全路径
 */
+ (NSString *)filePathWithURL:(NSURL *)url;
/**
 文件路径URL
 
 @param url 资源地址
 @return 缓存文件URL
 */
+ (NSURL *)fileURLWithURL:(NSURL *)url;
/**
 判断此URL资源是否需要缓存

 @param url URL
 @return <#return value description#>
 */
+ (BOOL)needCacheWithURL:(NSURL *)url;

/**
 判断文件本地是否存在
 
 @param url 资源地址
 @return 是否存在
 */
+ (BOOL)fileExistWithURL:(NSURL *)url;

/**
 保存数据到文件
 
 @param data 文件数据
 @param url 资源地址
 */
+ (void)fileSaveData:(NSData *)data withURL:(NSURL *)url;

@end
