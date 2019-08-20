//
// Created by huanghou  on 2017/3/22.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import "TDFApp.h"
#import "Reachability.h"
#import "CocoaSecurity.h"
#import "NSObject+YYModel.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import "TDFAppLocationManager.h"

static TDFApp *current_App = nil;

@interface TDFApp ()
@property(nonatomic, readwrite) NSString *appKey;
@property(nonatomic, readwrite) NSString *secret;
@property(nonatomic, readwrite) NSString *deviceIP;
@property(nonatomic, strong) NSLock      *lock;
@end

@implementation TDFApp {
}
+ (TDFApp *)current {
    return current_App;
}

+ (instancetype)registerAppWithSecret:(NSString *)secret appKey:(NSString *)appKey {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSParameterAssert(secret);
        NSParameterAssert(appKey);
        if (secret && appKey) {
            current_App = [[TDFApp alloc] init];
            current_App.appKey = appKey;
            current_App.secret = secret;
        }
    });
    return current_App;
}


- (instancetype)init {
    self = [super init];
    if (self) {
        self.lock = [[NSLock alloc] init];
    }
    return self;
}


#pragma mark

- (NSString *)systemName {
    return @"ios";
}

- (NSString *)systemVersion {
    return [[UIDevice currentDevice] systemVersion];
}

- (NSString *)appBuild {
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
}

- (NSString *)appVersion {
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
}

- (NSString *)networkType {
    Reachability  *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus status        = [reachability currentReachabilityStatus];
    switch (status) {
        case NotReachable:
            return @"6";
        case ReachableViaWiFi:
            return @"3";
        case ReachableViaWWAN:
            return [self WWANType];
    }
}
- (BOOL)networkReachable {
    Reachability  *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus status        = [reachability currentReachabilityStatus];
    
    return status != NotReachable;
}

- (NSString *)WWANType {
    CTTelephonyNetworkInfo *netinfo         = [[CTTelephonyNetworkInfo alloc] init];
    NSString               *radioTechnology = netinfo.currentRadioAccessTechnology;
    if ([radioTechnology isEqualToString:CTRadioAccessTechnologyGPRS] || [radioTechnology isEqualToString:CTRadioAccessTechnologyEdge]
        || [radioTechnology isEqualToString:CTRadioAccessTechnologyCDMA1x]
        || [radioTechnology isEqualToString:CTRadioAccessTechnologyWCDMA] || [radioTechnology isEqualToString:CTRadioAccessTechnologyHSDPA]
        || [radioTechnology isEqualToString:CTRadioAccessTechnologyHSUPA] || [radioTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0]
        || [radioTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA] || [radioTechnology isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB]
        || [radioTechnology isEqualToString:CTRadioAccessTechnologyeHRPD]) {
        return @"3";
    } else if ([radioTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
        return @"4";
    }
    return @"6";
}

- (NSString *)screenSize {
    return [NSString stringWithFormat:@"%.f X %.f", [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height];
}

- (NSString *)deviceName {
    return [[UIDevice currentDevice] name];
}

- (NSString *)deviceId {
    return [[CocoaSecurity md5:[UIDevice currentDevice].identifierForVendor.UUIDString] hexLower];
}

+ (void)getAppLocation {
    [TDFAppLocationManager getLocationWithSuccessBlock:^(CLLocationDegrees latitude, CLLocationDegrees longitude) {
        current_App.latitude = [@(latitude) stringValue];
        current_App.longitude = [@(longitude) stringValue];
        [TDFAppLocationManager stop];
    } failure:^(NSError *error) {
        [TDFAppLocationManager stop];
    }];
}
- (NSString *)location {
    if (!current_App.latitude || !current_App.longitude) {
        [TDFApp getAppLocation];
    }
    return [(@{@"longitude": current_App.longitude ?:@"", @"latitude": current_App.latitude?:@""}) yy_modelToJSONString];
}

+ (void)refreshDeviceIP {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSError         *error;
        NSURL           *ipURL = [NSURL URLWithString:@"http://ip.2dfire.com/json"];
        NSMutableString *ip    = [NSMutableString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
        NSData       *data   = [ip dataUsingEncoding:NSUTF8StringEncoding];
        if(error || !data){
            return;
        }
        NSDictionary *dict   = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (dict[@"ip"] && NO == [dict[@"ip"] isKindOfClass:[NSNull class]]) {
            current_App.deviceIP = dict[@"ip"];
        }
        else{
            current_App.deviceIP = nil;
        }
    });
}

- (NSString *)deviceResolution {
    UIScreen *screen = [UIScreen mainScreen];
    CGFloat screenX = [screen bounds].size.width * screen.scale;
    CGFloat screenY = [screen bounds].size.height * screen.scale;
    return [NSString stringWithFormat:@"%@ * %@", [@(screenX) stringValue], [@(screenY) stringValue]];
}

- (NSString *)deviceFullName {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceModel = [NSString stringWithCString:systemInfo.machine
                                               encoding:NSUTF8StringEncoding];
    
    // 模拟器
    if ([deviceModel isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceModel isEqualToString:@"x86_64"])       return @"Simulator";
    
    // iPhone 系列
    if ([deviceModel isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([deviceModel isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceModel isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceModel isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (GSM)";
    if ([deviceModel isEqualToString:@"iPhone3,2"])    return @"Verizon iPhone 4";
    if ([deviceModel isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (CDMA/Verizon/Sprint)";
    if ([deviceModel isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceModel isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceModel isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceModel isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceModel isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceModel isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceModel isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceModel isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceModel isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceModel isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceModel isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceModel isEqualToString:@"iPhone9,1"])    return @"iPhone 7 (CDMA)";
    if ([deviceModel isEqualToString:@"iPhone9,3"])    return @"iPhone 7 (GSM)";
    if ([deviceModel isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus (CDMA)";
    if ([deviceModel isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus (GSM)";
    if ([deviceModel isEqualToString:@"iPhone10,1"])    return @"iPhone 8 (CDMA)";
    if ([deviceModel isEqualToString:@"iPhone10,4"])    return @"iPhone 8 (GSM)";
    if ([deviceModel isEqualToString:@"iPhone10,2"])    return @"iPhone 8 Plus (CDMA)";
    if ([deviceModel isEqualToString:@"iPhone10,5"])    return @"iPhone 8 Plus (GSM)";
    if ([deviceModel isEqualToString:@"iPhone10,3"])    return @"iPhone X (CDMA)";
    if ([deviceModel isEqualToString:@"iPhone10,6"])    return @"iPhone X (GSM)";
    
    // iPod 系列
    if ([deviceModel isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([deviceModel isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([deviceModel isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([deviceModel isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([deviceModel isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([deviceModel isEqualToString:@"iPod7,1"])      return @"iPod Touch 6G";
    
    // iPad 系列
    if ([deviceModel isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([deviceModel isEqualToString:@"iPad1,2"])      return @"iPad 3G";
    
    if ([deviceModel isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([deviceModel isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([deviceModel isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([deviceModel isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([deviceModel isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([deviceModel isEqualToString:@"iPad2,7"])      return @"iPad Mini (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([deviceModel isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([deviceModel isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([deviceModel isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([deviceModel isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([deviceModel isEqualToString:@"iPad4,1"])      return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad4,2"])      return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([deviceModel isEqualToString:@"iPad4,4"])      return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,5"])      return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,6"])      return @"iPad Mini 2";
    if ([deviceModel isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([deviceModel isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    
    if ([deviceModel isEqualToString:@"iPad5,1"])      return @"iPad Mini 4";
    if ([deviceModel isEqualToString:@"iPad5,2"])      return @"iPad Mini 4";
    if ([deviceModel isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([deviceModel isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    
    if ([deviceModel isEqualToString:@"iPad6,3"])      return @"iPad PRO (12.9)";
    if ([deviceModel isEqualToString:@"iPad6,4"])      return @"iPad PRO (12.9)";
    if ([deviceModel isEqualToString:@"iPad6,7"])      return @"iPad PRO (9.7)";
    if ([deviceModel isEqualToString:@"iPad6,8"])      return @"iPad PRO (9.7)";
    if ([deviceModel isEqualToString:@"iPad6,11"])      return @"iPad 5";
    if ([deviceModel isEqualToString:@"iPad6,12"])      return @"iPad 5";
    
    if ([deviceModel isEqualToString:@"iPad7,1"])      return @"iPad PRO 2 (12.9)";
    if ([deviceModel isEqualToString:@"iPad7,2"])      return @"iPad PRO 2 (12.9)";
    if ([deviceModel isEqualToString:@"iPad7,3"])      return @"iPad PRO (10.5)";
    if ([deviceModel isEqualToString:@"iPad7,4"])      return @"iPad PRO (10.5)";
    
    return deviceModel;
}


@end
