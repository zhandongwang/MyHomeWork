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
    [self testOperation];
}

- (void)testOperation {
    NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1-----%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
         NSLog(@"2-----%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"3-----%@", [NSThread currentThread]);
    }];
    [op addExecutionBlock:^{
        NSLog(@"4-----%@", [NSThread currentThread]);
    }];
    op.completionBlock = ^{
        NSLog(@"done-----%@", [NSThread currentThread]);
    };
    
    [op start];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
//    [queue addOperation:op];
    NSLog(@"finished");
    
}

- (void)testDeadLock {
    dispatch_queue_t queue = dispatch_queue_create("com.bestswifter.queue", NULL);
    dispatch_sync(queue, ^{
        NSLog(@"current thread = %@", [NSThread currentThread]);//main
        dispatch_sync(dispatch_get_main_queue(), ^{//dead lock
            NSLog(@"current thread = %@", [NSThread currentThread]);
        });
    });
}


- (void)testApply {
    dispatch_queue_t queue = dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0);
    dispatch_apply(10, queue, ^(size_t index) {
        NSLog(@"now is at %d, %@",index ,[NSThread currentThread]);
    });
    NSLog(@"done");
}


- (void)testAsyncAndSync {
    dispatch_queue_t sQueue = dispatch_queue_create("fl.squeue", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t cQueue = dispatch_queue_create("fl.cqueue", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(sQueue, ^{
        NSLog(@"first--- in thread %@", [NSThread currentThread]);
    });
    dispatch_async(sQueue, ^{
        NSLog(@"seconde---in thread %@", [NSThread currentThread]);
    });
    dispatch_async(sQueue, ^{
        NSLog(@"third--- in thread %@", [NSThread currentThread]);
    });
    
    dispatch_async(sQueue, ^{
        NSLog(@"fourth---in thread %@", [NSThread currentThread]);
    });
    
    NSLog(@"out queue %@", [NSThread currentThread]);
    
    
}

- (void)testSerialQueue {
    dispatch_queue_t sQueue1 = dispatch_queue_create("com.fl.serialqueue1", NULL);
    dispatch_queue_t sQueue2 = dispatch_queue_create("com.fl.serialqueue2", NULL);
    dispatch_queue_t sQueue3 = dispatch_queue_create("com.fl.serialqueue3", NULL);
    
    dispatch_queue_t sTargetQueue = dispatch_queue_create("com.fl.targetserialqueue", NULL);
    
    dispatch_set_target_queue(sQueue1, sTargetQueue);
    dispatch_set_target_queue(sQueue2, sTargetQueue);
    dispatch_set_target_queue(sQueue3, sTargetQueue);
    
    dispatch_async(sQueue1, ^{
        for (int i = 0; i < 10; ++i) {
            NSLog(@"sQueue1 %@ %@", @(i), [NSThread currentThread]);
        }
    });
    
    dispatch_async(sQueue2, ^{
        for (int i = 0; i < 10; ++i) {
            NSLog(@"sQueue2 %@ %@", @(i), [NSThread currentThread]);
        }
    });
    
    dispatch_async(sQueue3, ^{
        for (int i = 0; i < 10; ++i) {
            NSLog(@"sQueue3 %@ %@", @(i), [NSThread currentThread]);
        }
    });
}



- (void)testConditionLock {
    __block NSInteger count = 8;
    NSCondition *condition = [[NSCondition alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"1 finished");
        [condition lock];
        count -= 1;
        NSLog(@"count = %ld",count);
        [condition signal];
        [condition unlock];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"2 finished");
        [condition lock];
        count -= 1;
        NSLog(@"count = %ld",count);
        [condition signal];
        [condition unlock];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"3 finished");
        [condition lock];
        count -= 1;
        NSLog(@"count = %ld",count);
        [condition signal];
        [condition unlock];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"4 finished");
        [condition lock];
        count -= 1;
        NSLog(@"count = %ld",count);
        [condition signal];
        [condition unlock];
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"5 finished");
        [condition lock];
        count -= 1;
        NSLog(@"count = %ld",count);
        [condition signal];
        [condition unlock];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"6 finished");
        [condition lock];
        count -= 1;
        NSLog(@"count = %ld",count);
        [condition signal];
        [condition unlock];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"7 finished");
        [condition lock];
        count -= 1;
        NSLog(@"count = %ld",count);
        [condition signal];
        [condition unlock];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:5];
        NSLog(@"8 finished");
        [condition lock];
        count -= 1;
        NSLog(@"count = %ld",count);
        [condition signal];
        [condition unlock];
    });
    
    NSLog(@"before update UI");
    while (count > 0) {
        [condition wait];
    }
    NSLog(@"count = %ld",count);
    NSLog(@"start update UI");
    
}
@end
