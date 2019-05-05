//
//  FLConcurrentViewController.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/5/5.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLConcurrentViewController.h"

@interface FLConcurrentViewController ()

@end

@implementation FLConcurrentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)show {
    [[NSRunLoop currentRunLoop] addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    //RunLoop中要至少有一个Timer 或 一个Source
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(testRunLoop) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    //创建监听者
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"RunLoop进入");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"RunLoop要处理Timers了");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"RunLoop要处理Sources了");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"RunLoop要休息了");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"RunLoop醒来了");
                break;
            case kCFRunLoopExit:
                NSLog(@"RunLoop退出了");
                break;
                
            default:
                break;
        }
    });
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    [[NSRunLoop currentRunLoop] run];
    CFRelease(observer);
}


- (void)practiceGCD {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    __block NSInteger count = 8;
    NSCondition *condition = [[NSCondition alloc] init];
    //    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"1 finished");
        [condition lock];
        count -= 1;
        [condition signal];
        [condition unlock];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"2 finished");
        [condition lock];
        count -= 1;
        [condition signal];
        [condition unlock];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"3 finished");
        [condition lock];
        count -= 1;
        [condition signal];
        [condition unlock];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"4 finished");
        [condition lock];
        count -= 1;
        [condition signal];
        [condition unlock];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"5 finished");
        [condition lock];
        count -= 1;
        [condition signal];
        [condition unlock];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"6 finished");
        [condition lock];
        count -= 1;
        [condition signal];
        [condition unlock];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"7 finished");
        [condition lock];
        count -= 1;
        [condition signal];
        [condition unlock];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"8 finished");
        [condition lock];
        count -= 1;
        [condition signal];
        [condition unlock];
    });
    
    NSLog(@"before update UI");
    while (count > 0) {
        [condition wait];
    }
    
}
@end
