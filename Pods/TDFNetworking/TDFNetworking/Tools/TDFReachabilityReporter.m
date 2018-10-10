//
//  TDFReachabilityReporter.m
//  TDFNetworking
//
//  Created by Octree on 12/6/17.
//  Copyright © 2017年 2dfire. All rights reserved.
//

#import "TDFReachabilityReporter.h"
#import <AFNetworking/AFURLSessionManager.h>
#import <objc/runtime.h>
#import <NSHash/NSString+NSHash.h>

#ifndef DEBUG
__attribute__((constructor))
static void startReachabilityReporter() {
    
    [[TDFReachabilityReporter sharedInstance] startMonitoring];
}

__attribute__((destructor))
static void stopReachabilityReporter() {
    [[TDFReachabilityReporter sharedInstance] stopMonitoring];
}
#endif

@implementation TDFReachabilityReporter

+ (instancetype)sharedInstance {
    
    static TDFReachabilityReporter *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[TDFReachabilityReporter alloc] initPrivacy];
    });
    return instance;
}

- (instancetype)initPrivacy {
    
    if (self = [super init]) {
        
    }
    return self;
}


- (void)startMonitoring {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkRequestDidFinish:) name:AFNetworkingTaskDidCompleteNotification object:nil];
}

- (void)stopMonitoring {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:AFNetworkingTaskDidCompleteNotification
                                                  object:nil];
}

- (NSString *)ttmForRequest:(NSURLRequest *)request {
    
    NSURLComponents *components = [NSURLComponents componentsWithURL:request.URL resolvingAgainstBaseURL:YES];
    
    for (NSURLQueryItem *item in components.queryItems) {
        
        if ([item.name isEqualToString:@"ttm"]) {
            return item.value;
        }
    }
    return nil;
}

- (void)networkRequestDidFinish:(NSNotification *)notification {
    NSError *error = nil;
    
    NSURLSessionTask *task = notification.object;
    NSURLRequest *request = task.originalRequest?: task.currentRequest;
    error = [task error] ?: notification.userInfo[AFNetworkingTaskDidCompleteErrorKey];
    
    if ([request.URL.absoluteString hasPrefix:@"http://trace.2dfire.com/1.gif"]) {
        return;
    }
    
    if (!error) {
        return;
    }
    
    NSInteger status = 0;
    
    NSURLResponse *response = [task response];
    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
        
        status = [(NSHTTPURLResponse *)response statusCode];
    } else {
        
        status = error.code;
    }
    
    NSString *ttm = [self ttmForRequest:request];
    if (ttm) {
        [self reportTTM:ttm status:status];
    }
}


- (void)reportTTM:(NSString *)ttm status:(NSInteger)status {
    
    NSURLComponents *components = [NSURLComponents componentsWithString:@"http://trace.2dfire.com/1.gif"];
    components.queryItems = @[
                              [NSURLQueryItem queryItemWithName:@"type" value:@"testReachability"],
                              [NSURLQueryItem queryItemWithName:@"ttm" value:ttm],
                              [NSURLQueryItem queryItemWithName:@"status_code" value:[NSString stringWithFormat:@"%zd", status]],
                              ];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = components.URL;
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    NSURLSessionDataTask *task = [manager dataTaskWithRequest:request completionHandler:nil];
    [task resume];
}


@end
