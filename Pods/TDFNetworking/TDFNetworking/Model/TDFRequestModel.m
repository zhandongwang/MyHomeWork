//
//  TDFRequestModel.m
//  TDFNetworking
//
//  Created by 於卓慧 on 5/7/16.
//  Copyright © 2016 2dfire. All rights reserved.
//

#import "TDFRequestModel.h"

@implementation TDFRequestModel

- (instancetype)init {
    if (self = [super init]) {
        self.signType = TDFHTTPRequestSignTypeBossAPI;
        self.requestType = TDFHTTPRequestTypeGET;
    }
    
    return self;
}

- (NSString *)convertURLPart:(NSString *)urlPart {
    NSMutableString  *mutableString = [urlPart mutableCopy];

    if ([mutableString hasPrefix:@"/"]) {
        [mutableString deleteCharactersInRange:NSMakeRange(0, 1)];
    }

    if ([mutableString hasSuffix:@"/"]) {
        [mutableString deleteCharactersInRange:NSMakeRange(mutableString.length - 1, 1)];
    }

    return [mutableString copy];
}

- (void)setServerRoot:(NSString *)serverRoot {
    _serverRoot = [self convertURLPart:serverRoot];
}

- (void)setActionPath:(NSString *)actionPath {
    _actionPath = [self convertURLPart:actionPath];
}

- (void)setApiVersion:(NSString *)apiVersion {
    _apiVersion = [self convertURLPart:apiVersion];
}

- (void)setServiceName:(NSString *)serviceName {
    _serviceName = [self convertURLPart:serviceName];
}

- (void)setParameters:(NSDictionary *)parameters
{
    NSMutableDictionary *tempDict = [NSMutableDictionary dictionaryWithDictionary:parameters];
    if(tempDict[@"session_key"]) {
        tempDict[@"session_key"] = @"";
    }
//    [tempDict removeObjectForKey:@"session_key"];
    _parameters = tempDict;
}


@end
