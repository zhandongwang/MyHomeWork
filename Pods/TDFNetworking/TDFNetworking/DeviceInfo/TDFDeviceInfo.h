//
//  TDFDeviceInfo.h
//  TDFNetworking
//
//  Created by 於卓慧 on 5/28/16.
//  Copyright © 2016 2dfire. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TDFDeviceInfo : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, readonly, copy) NSString *deviceID;

@end
