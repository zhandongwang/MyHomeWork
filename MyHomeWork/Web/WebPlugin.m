//
//  WebPlugin.m
//  MyHomeWork
//
//  Created by 凤梨 on 2018/11/6.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

#import "WebPlugin.h"

@implementation WebPlugin

- (NSString *)identifier {
    
    return @"me.octree.bridge.log";
}

- (NSString *)javascriptCode {
    
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:@"log" ofType:@"js"];
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:NULL];
}

- (void)log:(id)msg {
    
    NSLog(@"WebView Bridge: %@", [msg description]);
}


@end
