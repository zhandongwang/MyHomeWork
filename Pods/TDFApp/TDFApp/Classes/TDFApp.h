//
// Created by huanghou  on 2017/3/22.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDFApp : NSObject
/**
 * 应用的Key
 */
@property(nonatomic, readonly) NSString *appKey;
/**
 * 应用的secret
 */
@property(nonatomic, readonly) NSString *secret;
/**
 * 系统名称，固定返回ios
 */
@property(nonatomic, readonly) NSString *systemName;
/**
 * 系统版本
 */
@property(nonatomic, readonly) NSString *systemVersion;
/**
 * 应用版本,返回CFBundleVersion值
 */
@property(nonatomic, readonly) NSString *appVersion;

/**
 * 应用build号
 */
@property(nonatomic, readonly) NSString *appBuild;
/**
 * 当前网络类型 1.有线 2.wifi 3.3G 4.4G 5.5G
 */
@property(nonatomic, readonly) NSString *networkType;

/**
 是否有网
 */
@property(nonatomic, assign, readonly) BOOL networkReachable;

/**
 * 屏幕尺寸
 */
@property(nonatomic, readonly) NSString *screenSize;
/**
 * 设备名称
 */
@property(nonatomic, readonly) NSString *deviceName;
/**
 * 设备ID
 */
@property(nonatomic, readonly) NSString *deviceId;
/**
 * 地理位置
 */
@property(nonatomic, readonly) NSString *location;
/**
 * 本机外网IP
 */
@property(nonatomic, readonly) NSString *deviceIP;

/**
 设备分辨率
 */
@property (nonatomic, readonly) NSString *deviceResolution;

/**
 设备完整名称
 */
@property (nonatomic, copy) NSString *deviceFullName;

/**
 纬度
 */
@property (nonatomic, copy) NSString *latitude;

/**
 经度
 */
@property (nonatomic, copy) NSString *longitude;

/**
 * 获取目前的app信息，需要使用registerApp方法先注册app，否则返回nil
 * @return
 */
+ (TDFApp *)current;

+ (instancetype)registerAppWithSecret:(NSString *)secret appKey:(NSString *)appKey;

/**
 * 刷新设备IP
 */
+ (void)refreshDeviceIP;

+ (void)getAppLocation;
@end
