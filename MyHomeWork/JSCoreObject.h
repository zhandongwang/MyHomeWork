//
//  JSCoreObject.h
//  MyHomeWork
//
//  Created by 王战东 on 16/10/25.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <UIKit/UIKit.h>

@protocol CustomJSExport <JSExport>

JSExportAs(clientLog, - (void)logString:(NSString *)string callback:(NSString *)callback);

@end

@interface JSCoreObject : NSObject

- (instancetype)initWithWebView:(UIWebView *)webView;

@end
