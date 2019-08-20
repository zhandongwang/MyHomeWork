//
//  NSObject+UnRecognizeSelCrash.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/7/11.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import "NSObject+UnRecognizeSelCrash.h"
#import "NSObject+Analysis.h"
#import "FLForwardingTarget.h"

static FLForwardingTarget *_target = nil;

@implementation NSObject (UnRecognizeSelCrash)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _target = [[FLForwardingTarget alloc] init];
        [self user_swizzleOriginalCls:[self class] originalSEL:@selector(forwardingTargetForSelector:) swizzledSEL:@selector(fl_forwardingTargetForSelector:)];
    });
}

+ (BOOL)isWhiteListClass:(Class)class {
    NSString *clsStr = NSStringFromClass(class);
    if ([clsStr hasPrefix:@"_"]) {//内部类
        return NO;
    }
    BOOL isNullCls = [clsStr isEqualToString:NSStringFromClass([NSNull class])];
    
    BOOL isMyClass = [clsStr hasPrefix:@"FL"];//要被hook的类
    return isNullCls || isMyClass;
    
}

- (id)fl_forwardingTargetForSelector:(SEL)aSelector {
    //先调用自身，以免破坏原来的消息转发流程
    id result = [self fl_forwardingTargetForSelector:aSelector];
    if (result) {//返回了其他对象
        return result;
    }
    //限制hook范围
    BOOL isWhiteListClass = [[self class] isWhiteListClass:[self class]];
    if (!isWhiteListClass) {
        return nil;//不需要被hook
    }
    if (!result) {
        result = _target;
    }
    return result;
    
}


@end
