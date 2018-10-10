//
//  TDFNetworkSystemService.h
//  TDFNetworking
//
//  Created by 於卓慧 on 6/4/16.
//  Copyright © 2016 2dfire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDFNetworkSystemService : NSObject

- (nullable NSURLSessionDataTask *)getPadServer:(nonnull NSString *)shopCode
                                        success:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))successBlock
                                        failure:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, NSError * _Nullable error))failureBlock;

- (nullable NSURLSessionDataTask *)getChainServer:(nonnull NSString *)shopCode
                                          success:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject))successBlock
                                          failure:(nullable void (^)(NSURLSessionDataTask * _Nonnull task, NSError * _Nullable error))failureBlock;
@end
