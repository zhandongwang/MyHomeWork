//
//  HBWebEngine.h
//  weather
//
//  Created by CaydenK on 2016/11/28.
//  Copyright © 2016年 CaydenK. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HBWebViewController;
@class HBCookieModel;

@protocol HBJSBridgeProtocol;

/**
 URL 类型

 - HBWebEngineURLTypeNormal: 未知地址，默认类型
 - HBWebEngineURLTypeLichKing: 公司内部地址
 - HBWebEngineURLTypeWhite: 信任的地址
 - HBWebEngineURLTypeBlack: 不信任的地址
 - HBWebEngineURLTypeLocal: 本地地址
 - HBWebEngineURLTypeOther: 其他地址 - android
 - HBWebEngineURLTypeSpecifie: 活动特殊url - 如果不是成类型的其实没必要放这里处理
 */
typedef NS_ENUM(NSInteger, HBWebEngineURLType) {
    HBWebEngineURLTypeNormal   = 0,
    HBWebEngineURLTypeLichKing = 1,
    HBWebEngineURLTypeWhite    = 2,
    HBWebEngineURLTypeBlack    = 3,
    HBWebEngineURLTypeLocal    = 4,
    HBWebEngineURLTypeOther    = 5,
    HBWebEngineURLTypeSpecifie = 6
};

// 当前app语言获取block
typedef NSDictionary*(^HBAppLanguageFeatchBlock)();
extern NSString * const HBAppLanugageKey;
extern NSString * const HBLanugageBundleKey;

// token失效通知
extern NSString * const HBWebEngineTokenFailedNotification;

@interface HBWebEngine : NSObject

#pragma mark - Config Infos

/**
 app当前语言获取方法
 */
@property (class, copy, nonatomic) HBAppLanguageFeatchBlock appLanguageFetchBlock;
/**
 离线资源类型
 默认支持css,js,jpg,jpeg,png,gif 这些类型
 */
@property (class, strong, nonatomic) NSArray *enabledTypes;
/**
 缓存开关
 */
@property (class, assign, nonatomic) BOOL cacheSwitch;

@property (class, strong, nonatomic, readonly) NSArray *withoutSource;
@property (class, strong, nonatomic, readonly) NSDictionary *hybridConfig;
@property (class, strong, nonatomic, readonly) NSDictionary *scanPrompt;
@property (class, copy, nonatomic) NSString *customUserAgent;
@property (class, assign, nonatomic) BOOL debug;

/**
 更新 UA 中的语言信息
 */
+ (void)updateUserAngentLang;


/**
 设置cookie
 */
+ (void)setCookies:(NSArray<HBCookieModel *> *)cookies;
/**
 清除cookie
 */
+ (void)clearCookies;

#pragma mark - Engine

+ (void)registerHybridConfig:(NSDictionary *)hybridConfig scanPrompt:(NSDictionary *)scanPrompt;
/**
 启动网络URL拦截
 */
+ (void)startEngine;

/**
 清除缓存数据
 */
+ (void)clearCacheInfos;

/**
 缓存大小
 */
+ (unsigned long long)cacheSize;


///**
// URL 是否需要解析
// 
// @param url 待判断的url
// @return 是否需要解析  YES：需要  NO：不需要
// */
//+ (BOOL)needAnalyseURL:(NSURL *)url;

/**
 获取地址类型

 @param url 扫码拿到的URL
 @return URL类型
 */
+ (HBWebEngineURLType)typeOfURL:(NSURL *)url;

+ (HBWebViewController *)fetchWebVCWithURL:(NSURL *)url;
+ (HBWebViewController *)fetchWebVCWithURL:(NSURL *)url objPlugins:(NSArray<id<HBJSBridgeProtocol>> *)objPlugins;

/**
 用WebViewController打开URL
 
 @param url 地址  （此处当type为HBWebEngineURLTypeLichKing时，URL为解析后的地址）
 @param type URL类型
 @param callBack 回传生成的webViewController
 */
+ (void)openURL:(NSURL *)url type:(HBWebEngineURLType)type withWebViewControllerCallBack:(void(^)(HBWebViewController *webViewController))callBack __attribute__((deprecated("Deprecated! please use fetchWebVCWithURL:objPlugins:")));


@end
