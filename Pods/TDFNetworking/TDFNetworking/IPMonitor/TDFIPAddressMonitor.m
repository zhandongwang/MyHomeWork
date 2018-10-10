//
//  TDFIPAddressMonitor.m
//  AFNetworking
//
//  Created by Octree on 2017/10/12.
//

#import "TDFIPAddressMonitor.h"
#import <AFNetworking/AFNetworking.h>

@interface TDFIPAddressMonitor ()

@property (strong, nonatomic) AFNetworkReachabilityManager *reachabilityManager;
@property (strong, nonatomic) AFURLSessionManager *sessionManager;
@property (strong, nonatomic) NSURLSessionDataTask *currentTask;
@property (nonatomic) NSInteger retryTimes;
@property (copy, nonatomic) NSString *privateIP;

@end

@implementation TDFIPAddressMonitor

#pragma mark - Life Cycle

- (instancetype)initPrivate {
    if (self = [super init]) {
        
        _retryLimitation = 3;
        _retryInterval = 3;
    }
    return self;
}

+ (instancetype)sharedInstance {

    static TDFIPAddressMonitor *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TDFIPAddressMonitor alloc] initPrivate];
    });
    return instance;
}

#pragma mark - Public Method

- (void)startMonitoring {
    
    [self.reachabilityManager startMonitoring];
}


- (void)stopMonitoring {
    
    [self.reachabilityManager stopMonitoring];
}

#pragma mark - Private Method

- (void)updateIPAddress {
    
    NSURL *url = [NSURL URLWithString:@"https://ip.2dfire.com/json"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 10.0;
    __weak __typeof(self) wself = self;
    self.currentTask = [self.sessionManager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
       
        if (error && error.code != NSURLErrorCancelled) {
            [wself retryIfNeeded];
        } else if ([responseObject isKindOfClass:[NSDictionary class]]){
            wself.retryTimes = 0;
            NSDictionary *dict = (NSDictionary *)responseObject;
            wself.privateIP = dict[@"ip"];
        }
    }];
    [self.currentTask resume];
}

- (void)retryIfNeeded {
    
    if (self.retryTimes >= self.retryLimitation) {
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.retryInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.retryTimes += 1;
        [self updateIPAddress];
    });
}

#pragma mark - Accessor

- (void)cancelCurrentRequest {
    
    self.retryTimes = NSUIntegerMax;
    [self.currentTask cancel];
    self.retryTimes = 0;
}

- (AFNetworkReachabilityManager *)reachabilityManager {
    
    if (!_reachabilityManager) {
        
        _reachabilityManager = [AFNetworkReachabilityManager managerForDomain:@"www.baidu.com"];
        __weak __typeof(self) wself = self;
        [_reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusNotReachable:
                    break;
                case AFNetworkReachabilityStatusUnknown:
                case AFNetworkReachabilityStatusReachableViaWWAN:
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    [wself cancelCurrentRequest];
                    [wself updateIPAddress];
            }
        }];
    }
    return _reachabilityManager;
}

- (AFURLSessionManager *)sessionManager {
    
    if (!_sessionManager) {
        
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionManager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        _sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    return _sessionManager;
}

- (NSString *)ipAddress {
    
    return self.privateIP;
}

@end
