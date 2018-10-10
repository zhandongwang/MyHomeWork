//
//  TDFReachabilityReporter.h
//  TDFNetworking
//
//  Created by Octree on 12/6/17.
//  Copyright © 2017年 2dfire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDFReachabilityReporter : NSObject

+ (instancetype)sharedInstance;
- (instancetype)init NS_UNAVAILABLE;

- (void)startMonitoring;
- (void)stopMonitoring;
@end
