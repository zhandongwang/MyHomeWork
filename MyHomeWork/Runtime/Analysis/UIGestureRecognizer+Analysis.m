//
//  UIGestureRecognizer+Analysis.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/4/1.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "UIGestureRecognizer+Analysis.h"
#import "NSObject+Analysis.h"

@implementation UIGestureRecognizer (Analysis)
//+ (void)load {
//    [self user_swizzleOriginalCls:[UIGestureRecognizer class] originalSEL:@selector(initWithTarget:action:) swizzledSEL:@selector(user_initWithTarget:action:)];
//}

- (instancetype)user_initWithTarget:(id)target action:(SEL)action {
    UIGestureRecognizer *ges = [self user_initWithTarget:target action:action];
    if (!target || !action) {
        return ges;
    }

    //添加私有方法 sel：target.class/action.name  IMP:user_gestureRecognizer
    NSString *selName = [NSString stringWithFormat:@"%s/%@",class_getName([target class]),NSStringFromSelector(action)];
    
    SEL swizzledSel = NSSelectorFromString(selName);
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(user_gestureRecognizer:));
    
    BOOL isAdded = class_addMethod([target class], swizzledSel, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (isAdded) {
        [NSObject user_swizzleOriginalCls:[target class] originalSEL:action swizzledSEL:swizzledSel];
    }

    return ges;
}
//私有方法的实现
- (void)user_gestureRecognizer:(UIGestureRecognizer *)gesture {
    //上报日志
    NSString *identifier = [NSString stringWithFormat:@"%s/%@",class_getName([self class]),gesture.name];
    NSLog(@"%@",identifier);
    //执行
    SEL sel = NSSelectorFromString(identifier);
    if ([self respondsToSelector:sel]) {
        IMP imp = [self methodForSelector:sel];
        void(*func)(id, SEL, id) = (void*)imp;
        func(self, sel, gesture);
    }
}
@end
