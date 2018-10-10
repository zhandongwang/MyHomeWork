//
//  HBURLProtocol.m
//  weather
//
//  Created by CaydenK on 2016/11/24.
//  Copyright © 2016年 CaydenK. All rights reserved.
//

#import "HBURLProtocol.h"
#import <UIKit/UIKit.h>
#import "HBWebEngine.h"
#import "HBFileManager.h"
#import "HBMacroDefine.h"
#import "NSObject+HBHybridKit.h"

static NSString * const kHBURLProtocolKey = @"_kHBURLProtocolKey";
static NSUInteger const kHBRequestQueueMaxCount = 5;

@interface HBURLProtocol ()<NSURLSessionDelegate>

@property (strong, nonatomic) NSURLSession *session;
@property (strong, nonatomic) NSURLSessionDataTask *task;
@property (strong, nonatomic) NSMutableData *data;

@property (nonatomic, strong) NSThread *clientThread;

@end

@implementation HBURLProtocol

+ (NSOperationQueue *)requestQueue {
    static NSOperationQueue *hb_requestQueue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        hb_requestQueue = [[NSOperationQueue alloc] init];
        hb_requestQueue.name = @"com.2dfire.hybrid.session_queue";
        hb_requestQueue.maxConcurrentOperationCount = kHBRequestQueueMaxCount;
    });
    return hb_requestQueue;
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    if ([[NSURLProtocol propertyForKey:kHBURLProtocolKey inRequest:request] boolValue]) {
        return NO;
    }
    if (![HBWebEngine cacheSwitch]) {
        return NO;
    }
    
    NSDictionary *headerFields = request.allHTTPHeaderFields;
    NSString *userAgent = headerFields[@"User-Agent"];
    if (userAgent && [userAgent rangeOfString:kHBWebRequestUserAgentCustomInfo].location != NSNotFound) {
        return YES;
    }
    
    return NO;
}

+ (BOOL)requestIsCacheEquivalent:(NSURLRequest *)a toRequest:(NSURLRequest *)b {
    return [super requestIsCacheEquivalent:a toRequest:b];
}


+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request
{
    return request;
}


- (void)startLoading {
    assert(self.clientThread == nil); // // you can't call -startLoading twice
    self.clientThread = [NSThread currentThread];
    
    NSMutableURLRequest *request = self.request.mutableCopy;
    [HBURLProtocol setProperty:@(YES) forKey:kHBURLProtocolKey inRequest:request];
    
    NSURL *url = request.URL;
    if ([HBFileManager needCacheWithURL:url]) {
        if ([HBFileManager fileExistWithURL:url]) {
            NSURL *fileURL = [HBFileManager fileURLWithURL:url];
            request.URL = fileURL;
        }
    }

    NSURLSessionConfiguration *config = (NSURLSessionConfiguration *)({
        NSURLSessionConfiguration *_config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _config.protocolClasses = @[[self class]];
        _config;
    });
    
    self.session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[self.class requestQueue]];
    self.task = [self.session dataTaskWithRequest:request];
    [self.task resume];
}

- (void)stopLoading {
    [self.session invalidateAndCancel];
    [self.task cancel];
    self.task = nil;
}

#pragma mark - NSURLSessionDelegate
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    assert(self.clientThread);
    assert([NSThread currentThread] != [NSThread mainThread]);
    
    if( error ) {
        /**
         https://developer.apple.com/library/content/samplecode/CustomHTTPProtocol/Listings/Read_Me_About_CustomHTTPProtocol_txt.html
         
         In addition, an NSURLProtocol subclass is expected to call the various methods of the NSURLProtocolClient protocol from the client thread, including all of the following:
         -URLProtocol:wasRedirectedToRequest:redirectResponse:
         -URLProtocol:didReceiveResponse:cacheStoragePolicy:
         -URLProtocol:didLoadData:
         -URLProtocolDidFinishLoading:
         -URLProtocol:didFailWithError:
         -URLProtocol:didReceiveAuthenticationChallenge:
         -URLProtocol:didCancelAuthenticationChallenge:
         */
        [self hb_performOnThread:self.clientThread waitUntilDone:YES block:^{
            [self.client URLProtocol:self didFailWithError:error];
        }];
    } else {
        NSURL *url = task.response.URL;
        if ([HBFileManager needCacheWithURL:url] && ![url.scheme isEqualToString:@"file"]) {
            //此处不需要判断是否存在，因为startLoading的时候，已经判断过了，如果存在就是URL scheme为file
            [HBFileManager fileSaveData:self.data withURL:url];
        }
        NSURLRequest *request = task.currentRequest;
        if ([HBWebEngine typeOfURL:url] == HBWebEngineURLTypeLichKing) {
            //调用公司资源
            NSDictionary *requestHeader = request.allHTTPHeaderFields;
            NSString *accept = [requestHeader objectForKey:@"Accept"];
            if ([accept rangeOfString:@"application/json"].location != NSNotFound) {//逻辑请求ajax
                //解析data
                id data = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableContainers error:nil];
                if ([data isKindOfClass:[NSDictionary class]]) {
                    NSInteger code = [[data objectForKey:@"code"] integerValue];
                    if (code == -1) { //登出
                        dispatch_async(dispatch_get_main_queue(), ^{
                            //只管发-1，
                            [[NSNotificationCenter defaultCenter] postNotificationName:HBWebEngineTokenFailedNotification object:request];
                        });
                    }
                }
                
            }
        }
        /**
         https://developer.apple.com/library/content/samplecode/CustomHTTPProtocol/Listings/Read_Me_About_CustomHTTPProtocol_txt.html
         
         In addition, an NSURLProtocol subclass is expected to call the various methods of the NSURLProtocolClient protocol from the client thread, including all of the following:
         -URLProtocol:wasRedirectedToRequest:redirectResponse:
         -URLProtocol:didReceiveResponse:cacheStoragePolicy:
         -URLProtocol:didLoadData:
         -URLProtocolDidFinishLoading:
         -URLProtocol:didFailWithError:
         -URLProtocol:didReceiveAuthenticationChallenge:
         -URLProtocol:didCancelAuthenticationChallenge:
         */
        
        [self hb_performOnThread:self.clientThread waitUntilDone:YES block:^{
            [self.client URLProtocolDidFinishLoading:self];
        }];
    }
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    assert(self.clientThread);
    assert([NSThread currentThread] != [NSThread mainThread]);
    [self hb_performOnThread:self.clientThread waitUntilDone:YES block:^{
        [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageNotAllowed];
    }];
    completionHandler(NSURLSessionResponseAllow);
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    [self.data appendData:data];
    assert(self.clientThread);
    assert([NSThread currentThread] != [NSThread mainThread]);
    [self hb_performOnThread:self.clientThread waitUntilDone:YES block:^{
        [self.client URLProtocol:self didLoadData:data];
    }];
}


#pragma mark - Get & Set
- (NSMutableData *)data {
    if (!_data) {
        _data = [NSMutableData data];
    }
    return _data;
}

@end
