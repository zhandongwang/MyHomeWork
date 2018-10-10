//
//  TDFRecord.m
//  TDFDNSPod
//
//  Created by Octree on 5/8/16.
//  Copyright © 2016年 Octree. All rights reserved.
//

#import "TDFDNSRecord.h"

@implementation TDFDNSRecord

- (instancetype)initWithValue:(NSString *)value ttl:(NSInteger)ttl {

    if (self = [super init]) {
    
        _ttl = ttl;
        _value = value;
        _timestamp = [[NSDate date] timeIntervalSince1970];
    }
    
    return self;
}

- (BOOL)expired:(long long)time {

    return time > _timestamp + _ttl;
}

@end
