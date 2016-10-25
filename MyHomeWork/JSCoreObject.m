//
//  JSCoreObject.m
//  MyHomeWork
//
//  Created by 王战东 on 16/10/25.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import "JSCoreObject.h"

@interface JSCoreObject () <CustomJSExport>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation JSCoreObject

- (instancetype)initWithWebView:(UIWebView *)webView
{
    if (self = [super init]) {
        self.webView = webView;
    }
    return self;
}

- (void)logString:(NSString *)string callback:(NSString *)callback
{
    NSLog(@"%@", string);
    NSString *callbackJS = [NSString stringWithFormat:@"%@('我是callback')", callback];
    
    [self.webView performSelector:@selector(stringByEvaluatingJavaScriptFromString:) withObject:callbackJS afterDelay:1];
}

@end
