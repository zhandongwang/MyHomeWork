//
//  FLCar.m
//  MyHomeWork
//
//  Created by 凤梨 on 2018/11/8.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

#import "FLCar.h"
#import "FLPerson.h"

@implementation FLCar

+ (void)load {
    SEL selector = @selector(runTo:);
    Method targetMethod = class_getInstanceMethod(self.class, selector);
    const char *typeEncoding = method_getTypeEncoding(targetMethod);
    IMP targetMethodIMP = _objc_msgForward;
    class_replaceMethod(self.class, selector, targetMethodIMP, typeEncoding);
}

- (void)runTo:(NSString *)place {
    NSLog(@"car runTo %@",place);
}
+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    if (sel == @selector(runTo:))
//    {
//        class_addMethod(self, sel, (IMP)dynamicMethodRunTo, "v@:@");
//        return YES;
//    }
//
//    return [super resolveInstanceMethod:sel];
    return NO;
}

static void dynamicMethodRunTo(id self, SEL _cmd, id place) {
    NSLog(@"dynamicMethodRunTo  %@", place);
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
//    if (aSelector == @selector(runTo:)) {
//        return [[FLPerson alloc] init];
//    }
//    return [super forwardingTargetForSelector:aSelector];
    return nil;
}


//- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    if (aSelector == @selector(runTo:)) {
//        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
//    }
//    return [super methodSignatureForSelector:aSelector];
//}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
//    if (anInvocation.selector == @selector(runTo:)) {
//        void *argBuf = NULL;
//        NSUInteger numberOfArgs = anInvocation.methodSignature.numberOfArguments;
//        for (NSUInteger idx = 2; idx < numberOfArgs; idx++) {
//            const char *type = [anInvocation.methodSignature getArgumentTypeAtIndex:idx];
//            NSUInteger argSize;
//            NSGetSizeAndAlignment(type, &argSize, NULL);
//            if (!(argBuf = realloc(argBuf, argSize))) {
//                return;
//            }
//            [anInvocation getArgument:argBuf atIndex:idx];
//
//        }
//    } else {
//
//    }
}




@end
