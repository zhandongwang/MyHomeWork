//
//  TDFDeviceInfo.m
//  TDFNetworking
//
//  Created by 於卓慧 on 5/28/16.
//  Copyright © 2016 2dfire. All rights reserved.
//

#import "TDFDeviceInfo.h"

@interface TDFDeviceInfo ()
@property (nonatomic, readwrite, copy) NSString *deviceID;
@end

@implementation TDFDeviceInfo

+ (instancetype)sharedInstance {
    static TDFDeviceInfo *_sharedInstance = nil;

    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _sharedInstance = [[TDFDeviceInfo alloc] init];
    });

    return _sharedInstance;
}

- (NSString *)deviceID {
    if (!_deviceID) {
        _deviceID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];

        _deviceID = [_deviceID stringByReplacingOccurrencesOfString:@"-" withString:@""];

    }

    return _deviceID;
}

@end
