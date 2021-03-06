//
//  NSObject+Analysis.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/4/1.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "NSObject+Analysis.h"
#import <objc/runtime.h>

@implementation NSObject (Analysis)

+ (void)user_swizzleOriginalCls:(Class)cls originalSEL:(SEL)originalSEL swizzledSEL:(SEL)swizzledSEL {
    Method originalMethod = class_getInstanceMethod(cls, originalSEL);
    Method swizzledMethod = class_getInstanceMethod(cls, swizzledSEL);
    //直接设置originalSEL的IMP
    BOOL added = class_addMethod(cls, originalSEL, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (added) {//如果添加成功，则替换掉swizzledSEL的IMP
        class_replaceMethod(cls, swizzledSEL, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}
@end
