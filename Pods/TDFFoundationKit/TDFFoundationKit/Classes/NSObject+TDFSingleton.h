//
// Created by huanghou  on 2017/5/25.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol TDFSingleton
@optional
+ (instancetype)tdf_sharedInstance;
@end

@interface NSObject (TDFSingleton)


@end