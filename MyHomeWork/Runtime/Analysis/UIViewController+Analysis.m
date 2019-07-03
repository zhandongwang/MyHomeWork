//
//  UIViewController+Analysis.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/4/1.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "UIViewController+Analysis.h"
#import <objc/runtime.h>
#import "NSObject+Analysis.h"

@implementation UIViewController (Analysis)

//+ (void)load {
//    [self user_swizzleOriginalCls:[UIViewController class] originalSEL: @selector(viewDidLoad) swizzledSEL:@selector(user_viewDidLoad)];
//}

- (void)user_viewDidLoad {
    [self user_viewDidLoad];
    NSString *identifier = [NSString stringWithFormat:@"%@", [self class]];
    NSLog(@"%@",identifier);
}


- (void)user_viewWillAppear:(BOOL)animated {
    [self user_viewWillAppear:animated];
    NSString *identifier = [NSString stringWithFormat:@"%@", [self class]];
    NSLog(@"%@",identifier);
}

@end
