//
//  FLConcurrentViewController.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/5/5.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLConcurrentViewController.h"
#import "FLCustomOperation.h"

@interface FLConcurrentViewController ()

@property (nonatomic, strong) UIButton *testButton;
@property (nonatomic, strong) NSThread *thread;
@property (nonatomic, strong) UIView *wrapperView;

@end

@implementation FLConcurrentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self testOperation];
    self.wrapperView = [[UIView alloc] initWithFrame:CGRectMake(100, 150, 200, 50)];
    self.wrapperView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.wrapperView];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(testGes)];
    [self.wrapperView addGestureRecognizer:gesture];
    

    self.testButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 250, 100, 30)];
    [self.testButton setTitle:@"测试" forState:UIControlStateNormal];
    [self.testButton setBackgroundColor:[UIColor redColor]];
    [self.testButton addTarget:self action:@selector(test) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.testButton];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.thread = [[NSThread alloc] initWithBlock:^{
//        for (int i = 0; i < 100; ++i) {
//            NSThread *t = [NSThread currentThread];
//            if ([t isCancelled]) {
//                [NSThread exit];
//            }
//            NSLog(@"Task %@", t);
//            [NSThread sleepForTimeInterval:1];
//        }
//    }];
//    [self.thread setName:@"fengli"];
//    [self.thread start];
}

- (void)testGes {
    NSLog(@"%s",__func__);
}

- (void)threadEntry:(NSString *)param {
    NSLog(@"%@", param);
}
- (void)test {
//    [self.thread cancel];
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(threadEntry:) object:@"hello thread"];
    thread.name = @"FengliThread";
    [thread start];
//    [self testThread];
//    FLOperation *operation = [[FLOperation alloc] initWithObject:@"Hello Operation"];
//    [operation main];
    NSLog(@"%s",__func__);
    
}

- (void)testThread
{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"in dispatch_async%@",[NSThread currentThread]);
//        });
        NSLog(@"out dispatch_async%@",[NSThread currentThread]);
    dispatch_queue_t concurrentQueue = dispatch_queue_create("myConcurrentQueue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_queue_t serialQueue = dispatch_queue_create("mySerialQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_queue_t serialQueue = dispatch_queue_create("mySerialQueue", DISPATCH_QUEUE_SERIAL);
    
    //同步提交一个任务到串行队列
    dispatch_sync(concurrentQueue, ^{
        for (int i = 0; i < 50; i++)
        {
            NSLog(@"Task1 %@ %d", [NSThread currentThread], i);
        }
    });
    
    //同步提交一个任务到串行队列
    dispatch_sync(concurrentQueue, ^{
        for (int i = 0; i < 50; i++)
        {
            NSLog(@"Task2 %@ %d", [NSThread currentThread], i);
        }
    });
    
    //同步提交一个任务到串行队列
    dispatch_sync(concurrentQueue, ^{
        for (int i = 0; i < 50; i++)
        {
            NSLog(@"Task3 %@ %d", [NSThread currentThread], i);
        }
    });
    NSLog(@"completed ");
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


- (id)testNull {
    return nil;
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
