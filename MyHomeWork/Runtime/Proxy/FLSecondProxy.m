//
//  FLSecondProxy.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/3/21.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLSecondProxy.h"

@implementation FLSecondProxy

- (id)initWithTarge1:(id)t1  target2:(id)t2 {
    target1 = t1;
    target2 = t2;
    return self;
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    id target = [target1 methodSignatureForSelector:invocation.selector] ? target1 : target2;
    [invocation invokeWithTarget:target];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    NSMethodSignature *sig;
    sig = [target1 methodSignatureForSelector:sel];
    if (sig) {
        return sig;
    }
    return [target2 methodSignatureForSelector:sel];
    
}

- (BOOL)respondsToSelector:(SEL)aSelector {
    return [target1 respondsToSelector:aSelector] || [target2 respondsToSelector:aSelector];
}

@end
