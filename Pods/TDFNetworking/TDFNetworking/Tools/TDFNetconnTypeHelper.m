//
//  TDFNetconnTypeHelper.m
//  AFNetworking
//
//  Created by Octree on 19/12/2017.
//

#import "TDFNetconnTypeHelper.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <AFNetworking/AFNetworking.h>

@implementation TDFNetconnTypeHelper

+ (TDFNetconnType)netconnType {
    
    TDFNetconnType type = TDFNetconnTypeOthers;
    
    AFNetworkReachabilityManager *reachability = [AFNetworkReachabilityManager managerForDomain:@"www.baidu.com"];
    AFNetworkReachabilityStatus status = [reachability networkReachabilityStatus];
    
    switch (status) {
        // 没有网络
        case AFNetworkReachabilityStatusNotReachable:
            type = TDFNetconnTypeOthers;
            break;
            
        case AFNetworkReachabilityStatusReachableViaWiFi:// Wifi
            type = TDFNetconnTypeWIFI;
            break;
            
        case AFNetworkReachabilityStatusReachableViaWWAN:// 手机自带网络
        {
            // 获取手机网络类型
            CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
            
            NSString *currentStatus = info.currentRadioAccessTechnology;
            
            if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
                
                type = TDFNetconnTypeOthers;
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
                
                type = TDFNetconnTypeOthers;
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){
                
                type = TDFNetconnType3G;
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){
                
                type = TDFNetconnType3G;
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){
                
                type = TDFNetconnTypeOthers;
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
                
                type = TDFNetconnTypeOthers;
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
                
                type = TDFNetconnType3G;
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
                
                type = TDFNetconnType3G;
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
                
                type = TDFNetconnType3G;
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){
                
                type = TDFNetconnType3G;
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
                
                type = TDFNetconnType4G;
            }
        }
            break;
        default:
            break;
    }
    
    return type;
}

@end
