//
//  TDFRequestModel.h
//  TDFNetworking
//
//  Created by 於卓慧 on 5/7/16.
//  Copyright © 2016 2dfire. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFURLRequestSerialization.h>

typedef NS_ENUM(NSUInteger, TDFHTTPRequestType) {
    TDFHTTPRequestTypeGET,
    TDFHTTPRequestTypePOST,
    TDFHTTPRequestTypeHEAD,
    TDFHTTPRequestTypePUT,
    TDFHTTPRequestTypePATCH,
    TDFHTTPRequestTypeDELETE
};

typedef NS_ENUM(NSUInteger, TDFHTTPRequestSignType) {
    TDFHTTPRequestSignTypeNone,
    TDFHTTPRequestSignTypeBossAPI,//boss api
    TDFHTTPRequestSignTypeAppSecret,//api
    TDFHTTPRequestSignTypeAppGateWay
};

@interface TDFRequestModel : NSObject


@property (nonatomic, assign) float timeout;

@property (nonatomic, assign) TDFHTTPRequestType requestType;

@property (nonatomic, nonnull, copy) NSString * serviceName;

@property (nonatomic, nonnull, copy) NSString * env;

@property (nonatomic, nonnull, copy) NSString * actionPath;

@property (nonatomic, nonnull, copy) NSString * serverRoot;

@property (nonatomic, nullable, copy) NSString *apiVersion;

@property (nonatomic, nullable, copy) NSDictionary *parameters;

@property (nonatomic, assign) TDFHTTPRequestSignType signType;

@property (nonatomic, nullable, copy) void(^constructingBodyWithBlock)(id<AFMultipartFormData>  _Nonnull formData);

@end
