//
//  TDFDNSManager.h
//  TDFDNSPod
//
//  Created by Octree on 5/8/16.
//  Copyright © 2016年 Octree. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TDFDNSResponseSerializer;
@interface TDFDNSManager : NSObject

@property (copy, nonatomic) NSString *urlFormatter;

/**
 *  Time Out Interval
 */
@property (nonatomic) NSTimeInterval timeoutInterval;
@property (strong, nonatomic) TDFDNSResponseSerializer *responseSerializer;
@property (strong, nonatomic) NSPredicate *hostPredicate;


/**
 *  singleton
 *
 *  @return manager
 */
+ (instancetype)sharedManager;

/**
 *  通过域名获取 ip 地址
 *
 *  @param domain 域名
 *
 *  @return ip 地址，nullable
 */
- (NSString *)getIpByDomain:(NSString *)domain;

- (instancetype)init __unavailable;

@end
