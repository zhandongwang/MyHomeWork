//
//  TDFDNSManager.m
//  TDFDNSPod
//
//  Created by Octree on 5/8/16.
//  Copyright © 2016年 Octree. All rights reserved.
//

#import "TDFDNSManager.h"
#import "TDFDNSRecord.h"
#import "TDFDNSResponseSerializer.h"
#import "TDFDNSPodResponseSerializer.h"

static NSString *const kTDFHTTPDNSDefaultURLFormatter = @"http://119.29.29.29/d?dn=%@&ttl=1";
static const NSTimeInterval kTDFHTTPDNSTimeInterval = 1.5;
@interface TDFDNSManager ()

@property (strong, nonatomic) NSCache *cache;

@end

@implementation TDFDNSManager

#pragma mark - Life Cycle

+ (instancetype)sharedManager {

    static TDFDNSManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[TDFDNSManager alloc] initPrivate];
    });
    
    return manager;
}

- (instancetype)initPrivate {

    if (self = [super init]) {
    
        _timeoutInterval = kTDFHTTPDNSTimeInterval;
        _urlFormatter = kTDFHTTPDNSDefaultURLFormatter;
    }
    
    return self;
}

#pragma mark - Public Method

- (NSString *)getIpByDomain:(NSString *)domain {

    if (!domain) {
    
        return nil;
    }
    
    __block TDFDNSRecord *record = [self.cache objectForKey:domain];
    if (record && ![record expired: (long long)[[NSDate date] timeIntervalSince1970]]) {
        
        return record.value;
    }
    
    record = [self queryIpWithDomain:domain];
    
    if (record) {
    
        [self.cache setObject:record forKey:domain];
    }
    
    return record.value;
}


#pragma mark - Private Method

- (TDFDNSRecord *)queryIpWithDomain:(NSString *)domain {
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:self.urlFormatter, domain]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestUseProtocolCachePolicy
                                         timeoutInterval:self.timeoutInterval];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    __block TDFDNSRecord *record;
    
    TDFDNSResponseSerializer *serializer = self.responseSerializer ?: [[TDFDNSPodResponseSerializer alloc] init];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        record = [[serializer dnsRecordsForResponse:(NSHTTPURLResponse *)response data:data error:error] firstObject];
        dispatch_group_leave(group);
    }];
    
    [task resume];
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    return record;
}

#pragma mark -

- (NSCache *)cache {

    if (!_cache) {
    
        _cache = [[NSCache alloc] init];
    }
    
    return _cache;
}

@end
