//
//  NSObject+HBHybridKit.h
//  HBHybridKit
//
//  Created by infiq on 2017/8/12.
//

#import <Foundation/Foundation.h>

typedef void (^HBPerformBlock)();

@interface NSObject (HBHybridKit)

- (void)hb_performOnThread:(NSThread*)thread waitUntilDone:(BOOL)wait block:(HBPerformBlock)block;

@end
