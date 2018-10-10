//
//  TDFClientConfigRequestModel.m
//  Pods
//
//  Created by 於卓慧 on 6/21/16.
//
//

#import <TDFNetworking/TDFRequestModel.h>
#import "TDFClientConfigRequestModel.h"
#import "TDFNetworkingConstants.h"

@implementation TDFClientConfigRequestModel

+ (instancetype)requestModelWithActionPath:(NSString *)actionPath {
    TDFClientConfigRequestModel *requestModel = [[TDFClientConfigRequestModel alloc] init];
    
    requestModel.actionPath = actionPath;
    
    requestModel.requestType = TDFHTTPRequestTypePOST;

    
    return requestModel;
}

- (NSString *)serverRoot {
    return kTDFBossAPI;
}

- (NSString *)serviceName {
    return @"app";
}

- (NSString *)apiVersion {
    return @"v1";
}

- (TDFHTTPRequestSignType)signType {
    return TDFHTTPRequestSignTypeNone;
}

@end
