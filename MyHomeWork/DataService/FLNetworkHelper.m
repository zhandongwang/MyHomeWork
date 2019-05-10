//
//  FLNetworkHelper.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/5/10.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLNetworkHelper.h"
#import <AFNetworking/AFNetworking.h>

@interface FLNetworkHelper ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@end


@implementation FLNetworkHelper

+ (instancetype)helper {
    static FLNetworkHelper *helper = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        helper = [[FLNetworkHelper alloc] init];
    });
    return helper;
}


@end
