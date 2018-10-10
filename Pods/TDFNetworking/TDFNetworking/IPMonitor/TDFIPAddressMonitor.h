//
//  TDFIPAddressMonitor.h
//  AFNetworking
//
//  Created by Octree on 2017/10/12.
//

#import <Foundation/Foundation.h>


/**
 监听 IP 地址的变化
 */
@interface TDFIPAddressMonitor : NSObject

/**
 当前 ip 地址，有可能为空
 */
@property (copy, nonatomic, readonly) NSString *ipAddress;

/**
 获取失败后，尝试次数限制, default: 3
 */
@property (nonatomic) NSUInteger retryLimitation;

/**
 失败后，尝试间隔，单位：秒 default: 3
 */
@property (nonatomic) NSTimeInterval retryInterval;

+ (instancetype)sharedInstance;

- (instancetype)init NS_UNAVAILABLE;

/**
 开始监听
 */
- (void)startMonitoring;

/**
 取消监听
 */
- (void)stopMonitoring;

@end
