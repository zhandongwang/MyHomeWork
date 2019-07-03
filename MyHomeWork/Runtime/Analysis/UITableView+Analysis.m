//
//  UITableView+Analysis.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/4/1.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "UITableView+Analysis.h"
#import "NSObject+Analysis.h"

@implementation UITableView (Analysis)

//+ (void)load {
//    [self user_swizzleOriginalCls:[UITableView class] originalSEL:@selector(setDelegate:) swizzledSEL:@selector(user_setDelegate:)];
//}

- (void)user_setDelegate:(id<UITableViewDelegate>)delegate {
    [self user_setDelegate:delegate];
    
    SEL originalSel = @selector(tableView:didSelectRowAtIndexPath:);
    Method originalMethod = class_getInstanceMethod([delegate class], originalSel);
    //初始化一个名字为delegat.class/tableview.tag的selector
    SEL swizzledSel =  NSSelectorFromString([NSString stringWithFormat:@"%@/%ld",[self class], self.tag]);
    Method swizzledmethod = class_getInstanceMethod([self class], @selector(user_tableView:didSelectRowAtIndexPath:));
    //IMP执行交换后的user_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 方法
    class_addMethod([delegate class], swizzledSel, method_getImplementation(swizzledmethod), method_getTypeEncoding(swizzledmethod));
    
    //如果delegate没有实现- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    if (![self isContainSel:originalSel inClass:[delegate class]]) {
         class_addMethod([delegate class], originalSel, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    }
    
    [NSObject user_swizzleOriginalCls:[delegate class] originalSEL:originalSel swizzledSEL:swizzledSel];
}

- (BOOL)isContainSel:(SEL)sel inClass:(Class)class {
    unsigned int count;
    Method *list = class_copyMethodList(class, &count);
    for (int i = 0; i < count; ++i) {
        Method method = list[i];
        NSString *methodString = NSStringFromSelector(method_getName(method));
        if ([methodString isEqualToString:NSStringFromSelector(sel)]) {
            return YES;
        }
    }
    return NO;
}

- (void)user_tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //通过唯一标识的规则， 找到原来的方法 （即tableView:didSelectRowAtIndexPath: 方法）
    SEL originalSel = NSSelectorFromString([NSString stringWithFormat:@"%@/%ld",[tableView class],tableView.tag]);
    if ([self respondsToSelector:originalSel]) {
        IMP imp = [self methodForSelector:originalSel];
        void(*func)(id,SEL,id,id) = (void*)imp;
        func(self,originalSel,tableView, indexPath);
    }
    NSString *identifier = [NSString stringWithFormat:@"%@/%@/%ld",[self class],[tableView class],tableView.tag];
}
@end
