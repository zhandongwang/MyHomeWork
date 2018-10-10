//
//  TDFRecord.h
//  TDFDNSPod
//
//  Created by Octree on 5/8/16.
//  Copyright © 2016年 Octree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDFDNSRecord : NSObject

@property (copy, nonatomic, readonly) NSString *value;
@property (nonatomic, readonly) NSInteger ttl;
@property (nonatomic, readonly) long long timestamp;


- (instancetype)initWithValue:(NSString *)value ttl:(NSInteger)ttl;
- (BOOL)expired:(long long)time;

@end
