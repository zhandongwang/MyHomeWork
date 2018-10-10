//
//  HBWebEngine.m
//  weather
//
//  Created by CaydenK on 2016/11/28.
//  Copyright © 2016年 CaydenK. All rights reserved.
//

#import "HBWebEngine.h"
#import "HBURLProtocol.h"
#import "HBWebViewController.h"
#import "HBFileManager.h"
#import "HBMacroDefine.h"
#import "HBUtility.h"
#import "HBCookieModel.h"
#import "UIAlertView+HBExtend.h"
#import "HBWebInputModel.h"
#import "NSBundle+HBHybridKit.h"
#import "HBJSCenter.h"

NSString * const HBAppLanugageKey    = @"HBAppLanugageKey";
NSString * const HBLanugageBundleKey = @"HBLanugageBundleKey";

NSString * const kHBConfigUrlTypeList  = @"hybridUnifyList";
NSString * const kHBConfigUrlTypeRegex = @"matchUrl";
NSString * const kHBConfigUrlType      = @"targetType";
NSString * const kHBConfigUrlVerifyPath      = @"hostPath";

// token失效通知
NSString * const HBWebEngineTokenFailedNotification = @"_HBWebEngineTokenFailedNotification";

@interface HBWebEngine ()

@property (nonatomic, strong) NSDictionary *hybridConfig;
@property (nonatomic, strong) NSDictionary *scanPrompt;
@property (nonatomic, strong) NSArray *enabledTypes;
@property (nonatomic, assign) BOOL cacheSwitch;
@property (nonatomic, copy)   HBAppLanguageFeatchBlock appLanguageFetchBlock;
@property (copy, nonatomic) NSString *customUserAgent;
@property (assign, nonatomic) BOOL debug;

@property (nonatomic, copy) NSString *preUALang;

@end

@implementation HBWebEngine

+ (HBWebEngine *)shareEngine {
    static HBWebEngine *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[HBWebEngine alloc] init];
        shareInstance.cacheSwitch = YES;
    });
    return shareInstance;
}


+ (NSArray *)enabledTypes {
    return [self shareEngine].enabledTypes;
}
+ (void)setEnabledTypes:(NSArray *)enabledTypes {
    [self shareEngine].enabledTypes = enabledTypes;
}
+ (BOOL)cacheSwitch {
    return [self shareEngine].cacheSwitch;
}
+ (void)setCacheSwitch:(BOOL)cacheSwitch {
    [self shareEngine].cacheSwitch = cacheSwitch;
}

/**
 设置app当前语言获取方法

 @param block 获取方式
 */
+ (void)setAppLanguageFetchBlock:(HBAppLanguageFeatchBlock)block {
    [self shareEngine].appLanguageFetchBlock = block;
}


/**
 app当前语言获取方法

 @return 返回app当前语言获取方法
 */
+ (HBAppLanguageFeatchBlock)appLanguageFetchBlock {
    return [self shareEngine].appLanguageFetchBlock;
}

+ (void)setCustomUserAgent:(NSString *)customUserAgent {
    [self shareEngine].customUserAgent = customUserAgent;
}
+ (NSString *)customUserAgent {
    return [self shareEngine].customUserAgent;
}

+ (void)setDebug:(BOOL)debug {
    [self shareEngine].debug = debug;
}

+ (BOOL)debug {
    return [self shareEngine].debug;
}

+ (NSArray *)withoutSource {
    return @[@"hm.gif",@"0.gif",@"v.gif"];
}

+ (void)setCookies:(NSArray<HBCookieModel *> *)cookies{
    [cookies enumerateObjectsUsingBlock:^(HBCookieModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:@{
                                                                    NSHTTPCookieDomain:obj.cookieDomain ?: @"",
                                                                    NSHTTPCookiePath:@"/",
                                                                    NSHTTPCookieName:obj.cookieKey ?: @"",
                                                                    NSHTTPCookieValue:obj.cookieValue ?: @"",
                                                                    }];
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    }];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookieAcceptPolicy:NSHTTPCookieAcceptPolicyAlways];
}
+ (void)clearCookies {
    NSArray *cookies = [NSArray arrayWithArray:[[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]];
    for (NSHTTPCookie *cookie in cookies) {
//        if ([baseURL.host isEqualToString:cookie.properties[NSHTTPCookieDomain]]) {
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
//        }
    }
}
+ (NSDictionary *)hybridConfig {
    return [self shareEngine].hybridConfig;
}
+ (NSDictionary *)scanPrompt {
    return [self shareEngine].scanPrompt;
}

+ (void)registerHybridConfig:(NSDictionary *)hybridConfig scanPrompt:(NSDictionary *)scanPrompt {
    [self shareEngine].hybridConfig = hybridConfig;
    [self shareEngine].scanPrompt = scanPrompt;
}

+ (void)startEngine {
    [[self shareEngine] modifyWebViewRequestUserAgent];
    [NSURLProtocol registerClass:[HBURLProtocol class]];
    [HBFileManager copyResourceToDocument];
}

- (void)modifyWebViewRequestUserAgent {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    NSString *oldAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    NSString *newAgent = oldAgent;
    if ([oldAgent rangeOfString:self.customUserAgent].location == NSNotFound) {
        newAgent = [oldAgent stringByAppendingString:self.customUserAgent];
        NSString *build = [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleVersion"];
        newAgent = [newAgent stringByAppendingFormat:@".%@",build];
    }
    
    newAgent = [self newUserAngetAppendLang:newAgent];
    [[NSUserDefaults standardUserDefaults] registerDefaults:@{@"UserAgent":newAgent}];
}

- (NSString*)newUserAngetAppendLang:(NSString*)oldUserAgent {
    NSString *lang = @" 2dfire/zh_CN";
    NSString *newAgent = oldUserAgent;
    
    if (self.appLanguageFetchBlock) {
        lang = [NSString stringWithFormat:@" 2dfire/%@",self.appLanguageFetchBlock()[HBAppLanugageKey]] ?: @" 2dfire/zh_CN";
    }
    if (self.preUALang) {
        NSRange oldRange = [newAgent rangeOfString:self.preUALang];
        if (oldRange.location != NSNotFound) {
            newAgent = [newAgent stringByReplacingOccurrencesOfString:self.preUALang withString:lang];
        }else {
            newAgent = [newAgent stringByAppendingString:lang];
        }
    }else {
        newAgent = [newAgent stringByAppendingString:lang];
    }
    self.preUALang = lang;
    return newAgent;
}


/**
 更新 UA 中的语言信息
 */
+ (void)updateUserAngentLang {
    HBWebEngine *engine = [self shareEngine];
    [engine modifyWebViewRequestUserAgent];
}

/**
 清除缓存数据
 */
+ (void)clearCacheInfos {
    //清除所有本地包中数据
    [HBFileManager removeDocumentBundle];
    //预存包中数据重新存入document
    [HBFileManager copyResourceToDocument];
}
/**
 缓存大小
 */
+ (unsigned long long)cacheSize {
    return [HBFileManager bundleSize];
}

+ (HBWebEngineURLType)typeOfURL:(NSURL *)url {
    HBWebEngineURLType type = HBWebEngineURLTypeNormal;
    if ([@[@"http",@"https"] containsObject:url.scheme]) {
        //http(s)请求
        NSArray<NSDictionary*> *unifyList = [self shareEngine].hybridConfig[kHBConfigUrlTypeList];
        for (NSDictionary *dic in unifyList) {
            NSString *regex = dic[kHBConfigUrlTypeRegex];
            HBWebEngineURLType configType = [dic[kHBConfigUrlType] integerValue];
            BOOL needVerifyPath = [dic[kHBConfigUrlVerifyPath] boolValue];
            NSString *verifyStr;
            if (needVerifyPath) { // 是否需要全路径匹配
                verifyStr = url.absoluteString;
            }else {
                verifyStr = url.host;
            }
            
            if ([HBUtility verifyString:verifyStr containsRegex:regex]) {
                type = configType;
                break;
            }
        }
    } else if ([url.scheme isEqualToString:@"file"]) {
        type = HBWebEngineURLTypeLocal;
    }
    return type;
}
+ (HBWebViewController *)fetchWebVCWithURL:(NSURL *)url {
    return [self fetchWebVCWithURL:url objPlugins:nil];
}
+ (HBWebViewController *)fetchWebVCWithURL:(NSURL *)url objPlugins:(NSArray<id<HBJSBridgeProtocol>> *)objPlugins {
    if (url == nil) {
        NSString *invalidUrl = [self shareEngine].scanPrompt[@"invalidUrlPrompt"];
        [UIAlertView hb_showAlertViewWithTitle:[NSBundle hb_localizedStringForKey:@"Warn"] message:invalidUrl ?: [NSBundle hb_localizedStringForKey:@"CannotAccess"] cancelButtonTitle:[NSBundle hb_localizedStringForKey:@"OK"]  otherButtonTitles:nil handler:NULL];
        return nil;
    }
    if (objPlugins && [objPlugins isKindOfClass:[NSArray class]] && objPlugins.count > 0) {
        [objPlugins enumerateObjectsUsingBlock:^(id<HBJSBridgeProtocol>  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [HBJSCenter registerObject:obj];
        }];
    }
    HBWebViewController *webVC = [self webViewControllerWithURL:url];
    return webVC;
}


+ (void)openURL:(NSURL *)url type:(HBWebEngineURLType)type withWebViewControllerCallBack:(void(^)(HBWebViewController *webViewController))callBack{
    !callBack ?: callBack([self fetchWebVCWithURL:url]);
}

+ (HBWebViewController *)webViewControllerWithURL:(NSURL *)url {
    HBWebViewController *webViewController = [[HBWebViewController alloc] init];
    HBWebInputModel *inputModel = [[HBWebInputModel alloc] init];
    inputModel.url = url.absoluteString;
    [webViewController setValue:inputModel forKey:@"inputParams"];
    return webViewController;
}


#pragma mark - Get & Set
- (NSArray *)enabledTypes {
    if (!_enabledTypes) {
        //默认配置
        _enabledTypes = @[@"css",@"js",@"jpg",@"jpeg",@"png",@"gif"];
    }
    return _enabledTypes;
}

- (NSString *)customUserAgent {
    if (!_customUserAgent) {
        _customUserAgent = kHBWebRequestUserAgentCustomInfo;
    }
    return _customUserAgent;
}



@end
