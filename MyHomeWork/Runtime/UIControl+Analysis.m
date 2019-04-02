//
//  UIControl+Analysis.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/4/1.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "UIControl+Analysis.h"
#import "NSObject+Analysis.h"

@implementation UIControl (Analysis)

+ (void)load {
    [self user_swizzleOriginalCls:[UIControl class] originalSEL: @selector(sendAction:to:forEvent:) swizzledSEL:@selector(user_sendAction:to:forEvent:)];
}

- (void)user_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    [self user_sendAction:action to:target forEvent:event];
    
    NSString *identifier = [NSString stringWithFormat:@"%@/%@/%ld",[target class],NSStringFromSelector(action), self.tag];
    NSLog(@"%@",identifier);
}

@end
