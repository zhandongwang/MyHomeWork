//
//  TDFNetworkSystemService.m
//  TDFNetworking
//
//  Created by 於卓慧 on 6/4/16.
//  Copyright © 2016 2dfire. All rights reserved.
//

#import "TDFNetworkSystemService.h"
#import "TDFRequestModel.h"
#import "TDFHTTPClient.h"
#import "TDFNetworkingConstants.h"
#import "TDFDataCenter.h"

@implementation TDFNetworkSystemService

- (nullable NSURLSessionDataTask *)getPadServer:(NSString *)shopCode
                                        success:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))successBlock
                                        failure:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, NSError * _Nullable error))failureBlock {
    
    TDFRequestModel *requestModel = [[TDFRequestModel alloc] init];
    requestModel.serverRoot = kTDFClusterRoot;
    requestModel.serviceName = @"AssignPadServer";
    requestModel.requestType = TDFHTTPRequestTypePOST;
    requestModel.signType = TDFHTTPRequestSignTypeAppSecret;
    
    requestModel.parameters = @{
                                @"code" : [TDFDataCenter sharedInstance].shopCode,
                                @"type" : @(2)
                                };
    
    NSURLSessionDataTask *dataTask = [[TDFHTTPClient sharedInstance] sendRequestWithRequestModel:requestModel
                                                                                        progress:nil
                                                                                         success:^(NSURLSessionDataTask *task, id o) {
                                                                                             NSInteger code = [o[@"code"] integerValue];
                                                                                             
                                                                                             if (code == 1) {
                                                                                                 [TDFDataCenter sharedInstance].rerpServerRoot = o[@"serverRoot"];
                                                                                             }
                                                                                             
                                                                                             successBlock(task, o);
                                                                                         } failure:failureBlock];
    
    return dataTask;
    
}

- (nullable NSURLSessionDataTask *)getChainServer:(NSString *)shopCode
                                          success:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))successBlock
                                          failure:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, NSError * _Nullable error))failureBlock {
    
    TDFRequestModel *requestModel = [[TDFRequestModel alloc] init];
    requestModel.serverRoot = kTDFClusterRoot;
    requestModel.serviceName = @"AssignChainServer";
    requestModel.requestType = TDFHTTPRequestTypePOST;
    
    requestModel.parameters = @{
                                @"code" : [TDFDataCenter sharedInstance].shopCode,
                                };
    
    NSURLSessionDataTask *dataTask = [[TDFHTTPClient sharedInstance] sendRequestWithRequestModel:requestModel
                                                                                        progress:nil
                                                                                         success:^(NSURLSessionDataTask *task, id o) {
                                                                                             
                                                                                             NSInteger code = [o[@"code"] integerValue];
                                                                                             
                                                                                             if (code == 1) {
                                                                                                 [TDFDataCenter sharedInstance].rerpServerRoot = o[@"serverRoot"];
                                                                                             }
                                                                                             
                                                                                             successBlock(task, o);
                                                                                         } failure:failureBlock];
    
    return dataTask;
    
}

@end
