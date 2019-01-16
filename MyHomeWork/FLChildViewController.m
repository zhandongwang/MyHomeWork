//
//  WZDChildViewController.m
//  MyHomeWork
//
//  Created by 凤梨 on 2018/8/28.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

#import "FLChildViewController.h"
#include <pthread.h>
#import "DHOrderModel.h"
typedef void(^MyBlock)(void);

@interface FLChildViewController ()<FLBaseViewControllerProtocol>

@property (nonatomic, copy) MyBlock blockOne;
@property (nonatomic, copy) MyBlock blockTwo;
@property (nonatomic, strong) dispatch_source_t timer;
@end

@implementation FLChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.child = self;
//    [self practiceBlock];
//    [self practiceRunTime];
    
    DHOrderModel * __strong person_one = [[DHOrderModel alloc]init];
    
    DHOrderModel * __unsafe_unretained person_two = person_one;
    
    NSLog(@"person_one地址:%p",person_one);
    person_one = nil;
    
    NSLog(@"person_one:%@,person_one地址:%p",person_one,person_one);
    NSLog(@"person_two地址:%p",person_two);
    NSLog(@"person_two:%@",person_two);
}

void *run (void * param){
    NSLog(@"run");
    
    return NULL;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
}

- (void)swizzledViewWillAppear:(BOOL)animated {
    NSLog(@"swizzledViewWillAppear");
    [self swizzledViewWillAppear:animated];
}

- (void)practiceBlock {
    NSLog(@"start practiceBlock");
    self.blockOne = ^{
        [NSThread sleepForTimeInterval:3];
        NSLog(@"this is blockOne");
    };
    
    self.blockTwo = ^{
        [NSThread sleepForTimeInterval:5];
         NSLog(@"this is blockTwo");
    };
}

- (void)practiceRunTime {
    //messageForwading
    Method origMethod = class_getInstanceMethod([self class], @selector(viewWillAppear:));
    Method swizzledMethod = class_getInstanceMethod([self class], @selector(swizzledViewWillAppear:));
    if (class_addMethod([self class], @selector(swizzledViewWillAppear:), method_getImplementation(origMethod), method_getTypeEncoding(origMethod))) {
        method_exchangeImplementations(origMethod, swizzledMethod);
    }

}

- (void)practiceGCD {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    NSMutableArray *array = @[].mutableCopy;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        [array addObject:@1];
        [array addObject:@2];
        [NSThread sleepForTimeInterval:2];
        [array addObject:@3];
        [array addObject:@4];
        dispatch_semaphore_signal(semaphore);
        NSLog(@"%@",array);
    });
    
    dispatch_async(queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        [array addObject:@11];
        [array addObject:@22];
        [NSThread sleepForTimeInterval:4];
        [array addObject:@33];
        [array addObject:@44];
        dispatch_semaphore_signal(semaphore);
        NSLog(@"%@",array);
    });
    dispatch_async(queue, ^{
                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        [array addObject:@111];
        [array addObject:@222];
        [NSThread sleepForTimeInterval:6];
        [array addObject:@333];
        [array addObject:@444];
                dispatch_semaphore_signal(semaphore);
        NSLog(@"%@",array);
    });
    

//    dispatch_apply(10, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
//        NSLog(@"%ld",index);
//    });
    
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_group_enter(group);
//    self.blockOne();
//    dispatch_group_leave(group);
//
//    dispatch_group_enter(group);
//    self.blockTwo();
//    dispatch_group_leave(group);
//
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        NSLog(@"任务完成");
//    });
    
//    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
//    dispatch_source_set_timer(self.timer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
//    dispatch_source_set_event_handler(self.timer, ^{
//        NSLog(@"my timer");
//    });
//    dispatch_resume(self.timer);
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
