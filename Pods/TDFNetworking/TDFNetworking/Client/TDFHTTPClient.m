//
//  TDFHTTPClient.m
//  TDFNetworking
//
//  Created by 於卓慧 on 5/6/16.
//  Copyright © 2016 2dfire. All rights reserved.
//

#import "TDFHTTPClient.h"
#import "TDFDeviceInfo.h"
#import "TDFResponseModel.h"
#import "NSString+TDFNetworking.h"
#import "TDFDataCenter.h"
#import "TDFHTTPRequestSerializer.h"
#import "TDFIPAddressMonitor.h"
#import "TDFNetconnTypeHelper.h"
#import "TDFHTTPProxyProtocol.h"
#import "TDFHTTPSerializeProtocol.h"
#import <TDFHTTPDNSKit/TDFHTTPDNS.h>
#import <TDFDataCenterKit/TDFDataCenter.h>
#import <NSHash/NSString+NSHash.h>
#import <CocoaSecurity/CocoaSecurity.h>

@interface TDFHTTPClient ()

@end

@implementation TDFHTTPClient

+ (instancetype)sharedInstance {
    static TDFHTTPClient *_sharedClient = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
                
        _sharedClient = [[TDFHTTPClient alloc] initWithSessionConfiguration:configuration];
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        
        _sharedClient.requestSerializer = [[TDFHTTPRequestSerializer alloc] init];
        _sharedClient.responseSerializer = [[AFJSONResponseSerializer alloc] init];
        
        NSMutableSet *contentTypes = [_sharedClient.responseSerializer.acceptableContentTypes mutableCopy];
        [contentTypes addObject:@"text/plain"];
        
        _sharedClient.responseSerializer.acceptableContentTypes = [contentTypes copy];
        
        _sharedClient.requestSerializer.timeoutInterval = kTDFNetworkingDefaultTimeout;
        [[TDFIPAddressMonitor sharedInstance] startMonitoring];
    });
    
    return _sharedClient;
}


- (nonnull NSURLSessionDataTask *)sendRequestWithRequestModel:(nonnull TDFRequestModel *)requestModel
                                                     progress:(nullable void (^)(NSProgress *_Nullable))progressBlock
                                                     callback:(nullable void (^)(TDFResponseModel *_Nullable))callback {
    
    NSParameterAssert(requestModel.serverRoot.length > 0);
    NSParameterAssert(requestModel.serviceName.length > 0);
    NSAssert(self.modelSerializer!=nil, @"TDFNetworking require model_serializer to serialize requestModel");
    
    NSURLSessionDataTask *sessionDataTask = nil;
    
    !self.proxy?:[self.proxy beforeRequestSendWithRequestObject:requestModel];
    
    //默认GET参数
    NSDictionary *defaultGETParams = [self.modelSerializer tdf_defaultGETParamsWithRequest:requestModel];
    
    //URL解析
    NSString *urlString = [self.modelSerializer tdf_URLWithRequest:requestModel defaultGETParams:defaultGETParams];
    
    //重复参数
    NSMutableArray *blockedKeys = [NSMutableArray array];
    [defaultGETParams enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        [blockedKeys addObject:key];
    }];
    
    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionaryWithCapacity:4];;
    
    //业务参数
    [[self.modelSerializer tdf_paramsWithRequest:requestModel] enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        if (![blockedKeys containsObject:key]) {
            mutableParameters[key] = obj;
        }
    }];
    
    //header
    [[self.modelSerializer tdf_HTTPHeaderFieldWithRequest:requestModel] enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        [self.requestSerializer setValue:obj forHTTPHeaderField:key];
    }];
    
    //默认业务参数
    [[self.modelSerializer tdf_defaultParamsWithRequest:requestModel] enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSString * _Nonnull obj, BOOL * _Nonnull stop) {
        if (![requestModel.parameters.allKeys containsObject:key]) {
            mutableParameters[key] = obj;
        }
    }];
    
    //签名
    NSString *sign = [self.modelSerializer tdf_signWithRequest:requestModel
                                                    parameters:mutableParameters
                                                           URL:urlString];
    
    if (sign) mutableParameters[@"sign"] = sign;
    
    NSDictionary *parameters = [mutableParameters copy];
    
    if (requestModel.timeout > kTDFNetworkingDefaultTimeout) {
        self.requestSerializer.timeoutInterval = requestModel.timeout;
    }
    
    void (^successBlock)(NSURLSessionDataTask *, id) = ^(NSURLSessionDataTask *task, id oresponseObject)
    {
        TDFResponseModel *responseModel = [[TDFResponseModel alloc] init];
        responseModel.responseObject = oresponseObject;
        responseModel.sessionDataTask = task;
        
        if (self.proxy && (![self.proxy shouldContinueResponse:responseModel withRequestObject:requestModel])) return ;
        
        if(callback) {
            callback(responseModel);
        }
        NSInteger code = [oresponseObject[@"code"] integerValue];
        if (code != 1) {
            NSDictionary *info = nil;
            
            if (oresponseObject) info = @{@"respoonse" : oresponseObject};
        }
    };
    
    void (^failureBlock)(NSURLSessionDataTask *, NSError *) = ^(NSURLSessionDataTask *task, NSError *error) {
        TDFResponseModel *responseModel = [[TDFResponseModel alloc] init];
        
        NSDictionary *userInfo = @{NSLocalizedDescriptionKey : NSLocalizedString(@"网络不给力，请稍后再试", nil)};
        error = [NSError errorWithDomain:@"TDF" code:error.code userInfo:userInfo];
        
        responseModel.error = error;
        
        responseModel.sessionDataTask = task;
        
        !self.proxy?:[self.proxy requestFailWithResponse:responseModel withRequestObject:requestModel];
        
        if(callback) {
            callback(responseModel);
        }
    };
    
    switch (requestModel.requestType) {
            
        case TDFHTTPRequestTypeGET: {
            sessionDataTask = [self GET:urlString parameters:parameters progress:progressBlock success:successBlock failure:failureBlock];
        }
            break;
        case TDFHTTPRequestTypePOST:
            if (requestModel.constructingBodyWithBlock) {
                sessionDataTask = [self POST:urlString parameters:parameters constructingBodyWithBlock:requestModel.constructingBodyWithBlock progress:progressBlock success:successBlock failure:failureBlock];
            }else {
                sessionDataTask = [self POST:urlString parameters:parameters progress:progressBlock success:successBlock failure:failureBlock];
            }
            
            break;
        case TDFHTTPRequestTypeHEAD: {
            sessionDataTask = [self HEAD:urlString parameters:parameters success:^(NSURLSessionDataTask *task) {
                successBlock(task, nil);
            }                    failure:failureBlock];
        }
            
            break;
        case TDFHTTPRequestTypePUT:
            sessionDataTask = [self PUT:urlString parameters:parameters success:successBlock failure:failureBlock];
            break;
        case TDFHTTPRequestTypePATCH:
            sessionDataTask = [self PATCH:urlString parameters:parameters success:successBlock failure:failureBlock];
            break;
        case TDFHTTPRequestTypeDELETE:
            sessionDataTask = [self DELETE:urlString parameters:parameters success:successBlock failure:failureBlock];
            break;
    }
    
    return sessionDataTask;
}

#pragma mark - property

- (nonnull NSURLSessionDataTask *)sendRequestWithRequestModel:(nonnull TDFRequestModel *)requestModel
                                                     progress:(nullable void (^)(NSProgress * _Nullable))progressBlock
                                                      success:(nonnull void (^)(NSURLSessionDataTask * _Nullable, id _Nullable))successBlock
                                                      failure:(nonnull void (^)(NSURLSessionDataTask *_Nullable, NSError *_Nullable))failureBlock {
    return  [self sendRequestWithRequestModel:requestModel progress:progressBlock callback:^(TDFResponseModel * _Nullable model) {
        if (model.error) {
            if(failureBlock) {
                failureBlock(model.sessionDataTask, model.error);
            }
        }else {
            if(successBlock) {
                successBlock(model.sessionDataTask, model.responseObject);
            }
        }
    }];
}

@end
