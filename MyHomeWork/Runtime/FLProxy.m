//
//  FLProxy.m
//  MyHomeWork
//
//  Created by 凤梨 on 2018/11/8.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

#import "FLProxy.h"

@interface FLProxy () {
    FLBookProvider *_book;
    FLClothesProvider *_clothes;
    NSMutableDictionary *_methodsMap;
}

@end

@implementation FLProxy

+ (id)proxyForObject:(id)obj {
    FLProxy *instance = [FLProxy alloc];
    instance->_object = obj;
    return instance;
    
}

+ (instancetype)dealerProxy {
    return [[FLProxy alloc] init];
}

- (instancetype)init {
    _methodsMap = [NSMutableDictionary dictionary];
    _book = [FLBookProvider new];
    _clothes = [FLClothesProvider new];
    [self _registerMethodsWithTarget:_book];
    [self _registerMethodsWithTarget:_clothes];
    
    return self;
}

- (void)_registerMethodsWithTarget:(id )target {
    unsigned int count = 0;
    Method *method_list = class_copyMethodList([target class], &count);
    for (int i = 0; i < count; ++i) {
        Method temp_method = method_list[i];
        SEL temp_sel =  method_getName(temp_method);
        const char *temp_method_name = sel_getName(temp_sel);
        [_methodsMap setObject:target forKey:[NSString stringWithUTF8String:temp_method_name]];
    }
    free(method_list);
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
//    NSString *name = NSStringFromSelector(sel);
//    id target = _methodsMap[name];
//
//    if (target && [target respondsToSelector:sel]) {
//        return [target methodSignatureForSelector:sel];
//    } else {
//        return [super methodSignatureForSelector:sel];
//    }
    return [_object methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
//    SEL sel = invocation.selector;
//    NSString *name = NSStringFromSelector(sel);
//    id target = _methodsMap[name];
//    if (target && [target respondsToSelector:sel]) {
//        [invocation invokeWithTarget:target];
//    } else {
//        [super forwardInvocation:invocation];
//    }
    if ([_object respondsToSelector:invocation.selector]) {
        NSString *name = NSStringFromSelector(invocation.selector);
        NSLog(@"Before Calling  %@",name);
        [invocation invokeWithTarget:_object];
        NSLog(@"After Calling  %@",name);
    }
    
}


@end
