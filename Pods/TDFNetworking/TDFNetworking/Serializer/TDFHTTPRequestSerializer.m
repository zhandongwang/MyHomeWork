//
//  TDFHTTPRequestSerializer.m
//  TDFNetworking
//
//  Created by 於卓慧 on 2016/11/1.
//  Copyright © 2016年 2dfire. All rights reserved.
//

#import "TDFHTTPRequestSerializer.h"
#import <TDFDataCenterKit/TDFDataCenter.h>

@implementation TDFHTTPRequestSerializer

- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request withParameters:(id)parameters error:(NSError *__autoreleasing  _Nullable *)error {
    NSMutableURLRequest *mutableRequest = [[super requestBySerializingRequest:request withParameters:parameters error:error] mutableCopy];
    
    NSMutableDictionary<NSString *, NSString *> *headers = [mutableRequest.allHTTPHeaderFields mutableCopy];
    
    headers[@"version"] = @"sso";
    if ([TDFDataCenter sharedInstance].bossToken.length > 0) {
        
        headers[@"sessionId"] = [TDFDataCenter sharedInstance].bossToken;
    }
    
    if ([TDFDataCenter sharedInstance].language.length > 0) {
        headers[@"lang"] = [TDFDataCenter sharedInstance].language;
    }
    
    NSString *MemSeId = [[NSUserDefaults standardUserDefaults] objectForKey:@"memSessId"];
    if(MemSeId) {
        headers[@"memberSessionId"] = MemSeId;
    }

    mutableRequest.allHTTPHeaderFields = headers;
    
    return mutableRequest;
}

@end
