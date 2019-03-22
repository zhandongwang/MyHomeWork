//
//  FLTestModel.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/3/7.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLTestModel.h"
#import "DHUserModel.h"

@implementation FLTestModel

+ (void)load {
    SEL sel = @selector(runTo:);
    class_replaceMethod(self, sel, _objc_msgForward, method_getTypeEncoding(class_getInstanceMethod(self, sel)));
}


//- (void)runTo:(NSString *)place {
//    NSLog(@"Car run %@", place);
//}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(runTo:)) {
        class_addMethod(self, sel, (IMP)dynamicMethodTo, "v@:@");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

static void dynamicMethodTo(id self, SEL _cmd, id place) {
    NSLog(@"dynamic runTo:");
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if (aSelector == @selector(runTo:)) {
        return [[DHUserModel alloc] init];
    }
    return [super forwardingTargetForSelector:aSelector];

}


- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == @selector(runTo:)) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if (anInvocation.selector == @selector(runTo:)) {
        //do your things
    } else {
        [super forwardInvocation:anInvocation];
    }
}


@end
