//
//  NSObject+HBHybridKit.m
//  HBHybridKit
//
//  Created by infiq on 2017/8/12.
//

#import "NSObject+HBHybridKit.h"

@implementation NSObject (HBHybridKit)

- (void)hb_performOnThread:(NSThread*)thread waitUntilDone:(BOOL)wait block:(HBPerformBlock)block {
    thread = thread ?: [NSThread currentThread];
    [self performSelector:@selector(hb_execBlock:) onThread:thread withObject:block waitUntilDone:wait];
}

- (void)hb_execBlock:(HBPerformBlock)block {
    if (block) {
        block();
    }
}

@end
