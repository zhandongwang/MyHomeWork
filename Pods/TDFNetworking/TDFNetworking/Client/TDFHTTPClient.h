//
//  TDFHTTPClient.h
//  TDFNetworking
//
//  Created by 於卓慧 on 5/6/16.
//  Copyright © 2016 2dfire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "TDFRequestModel.h"

@protocol TDFHTTPProxyProtocol;
@protocol TDFHTTPSerializeProtocol;
@class TDFResponseModel;

static CGFloat kTDFNetworkingDefaultTimeout = 15.0f;

@interface TDFHTTPClient : AFHTTPSessionManager

+ (nonnull instancetype)sharedInstance;

@property (weak, nonatomic) _Nullable id<TDFHTTPProxyProtocol> proxy;
@property (nonnull, nonatomic) id<TDFHTTPSerializeProtocol> modelSerializer;

//@property (nonnull, nonatomic, copy) NSString *tdf_appKey;
//@property (nonnull, nonatomic, copy) NSString *tdf_appSecret;
//@property (nonnull, nonatomic, copy) NSString *tdf_bossAppKey;
//@property (nonnull, nonatomic, copy) NSString *tdf_bossAppSecret;
//@property (nonnull, nonatomic, copy) NSString *tdf_GWAppSecret;

- (nonnull NSURLSessionDataTask *)sendRequestWithRequestModel:(nonnull TDFRequestModel *)requestModel
                                                     progress:(nullable void (^)(NSProgress *_Nullable))progressBlock
                                                     callback:(nullable void (^)(TDFResponseModel *_Nullable))callback;

- (nonnull NSURLSessionDataTask *)sendRequestWithRequestModel:(nonnull TDFRequestModel *)requestModel
                                                     progress:(nullable void (^)(NSProgress * _Nullable))progressBlock
                                                      success:(nonnull void (^)(NSURLSessionDataTask * _Nullable, id _Nullable))successBlock
                                                      failure:(nonnull void (^)(NSURLSessionDataTask *_Nullable, NSError *_Nullable))failureBlock DEPRECATED_ATTRIBUTE;

@end
