//
//  FLProxy.m
//  MyHomeWork
//
//  Created by 凤梨 on 2018/11/8.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

#import "FLProxy.h"

@implementation FLProxy

+ (id)proxyForObject:(id)obj {
    FLProxy *instance = [FLProxy alloc];
    instance->_objct = obj;
    return instance;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [_objct methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
//    if ([_objct respondsToSelector:invocation.selector]) {
//
//        NSURL *retValue;
//        [invocation getReturnValue:&retValue];
//
//        NSString *name = NSStringFromSelector(invocation.selector);
//        NSLog(@"Before calling %@", name);
//        [invocation invokeWithTarget:_objct];
//        NSLog(@"After calling %@,",name);
//
//    }
    [invocation invokeWithTarget:_objct];
}


@end
