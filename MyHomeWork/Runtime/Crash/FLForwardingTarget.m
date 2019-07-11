//
//  FLForwardingTarget.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/7/11.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import "FLForwardingTarget.h"

@implementation FLForwardingTarget

id ForwardingTarget_dynamicMethod(id self, SEL _cmd) {
    NSLog(@"got a crash:class:%@,sel:%@",[self class],NSStringFromSelector(_cmd));
    
    return [NSNull null];
}


+ (BOOL)resolveInstanceMethod:(SEL)sel {
    class_addMethod([self class], sel, (IMP)ForwardingTarget_dynamicMethod, "@@:");
    [super resolveInstanceMethod:sel];
    return YES;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return  [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [super forwardInvocation:anInvocation];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    [super doesNotRecognizeSelector:aSelector];
}

@end
