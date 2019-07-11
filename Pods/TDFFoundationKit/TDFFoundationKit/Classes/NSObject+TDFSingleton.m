//
// Created by huanghou  on 2017/5/25.
// Copyright (c) 2017 2dfire. All rights reserved.
//

#import "NSObject+TDFSingleton.h"
#import <objc/runtime.h>

@implementation NSObject (TDFSingleton)

+ (instancetype)tdf_sharedInstance {
    if (![self conformsToProtocol:@protocol(TDFSingleton)]) {
        [self doesNotRecognizeSelector:_cmd];
    }

    @synchronized (self) {
        id instance = objc_getAssociatedObject(self, _cmd);
        if (!instance) {
            instance = [[self alloc] init];
            objc_setAssociatedObject(self, _cmd, instance, OBJC_ASSOCIATION_RETAIN);
        }
        return instance;
    }
}

@end