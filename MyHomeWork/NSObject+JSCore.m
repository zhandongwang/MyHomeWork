//
//  NSObject+JSCore.m
//  MyHomeWork
//
//  Created by 王战东 on 16/10/25.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import "NSObject+JSCore.h"
#import <JavaScriptCore/JavaScriptCore.h>

@implementation NSObject (JSCore)

- (void)webView:(id)unuse didCreateJavaScriptContext:(JSContext *)ctx forFrame:(id)frame {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"didCreateJsContextNotification" object:ctx];
}

@end
