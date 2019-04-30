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
#import "DHOrderKind.h"
//#import "DHOrderDishModel.h"
#import "FLOperationFactory.h"
#import "FLOperation.h"

#import "FLCashRebate.h"
#import "FLCashNormal.h"
#import "FLCashContext.h"

#import "FLBuilder.h"
#import "FLDoor.h"
#import "FLEngine.h"
#import "FLWheel.h"

#import "FLFMDBHelper.h"
#import <ReactiveObjC/ReactiveObjC.h>

#import "DHUserModel.h"
#import "FLTestModel.h"
#import "NSObject+Analysis.h"
#import <WeexSDK/WeexSDK.h>

typedef void(^MyBlock)(void);
typedef void(^MyParamBlock)(NSString *str);
@interface FLChildViewController ()<FLBaseViewControllerProtocol>

@property (nonatomic, copy) MyParamBlock blockOne;
@property (nonatomic, copy) MyBlock blockTwo;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, strong) DHOrderModel *orderModel;

@property (nonatomic, strong) WXSDKInstance *wxInstance;
@end

@implementation FLChildViewController
//+ (void)load {
//    [self user_swizzleOriginalCls:[FLChildViewController class] originalSEL:@selector(viewWillAppear:) swizzledSEL:@selector(child_swizzledViewWillAppear:)];
//}

- (void)child_swizzledViewWillAppear:(BOOL)ani {
    [self child_swizzledViewWillAppear:ani];
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.wxInstance = [[WXSDKInstance alloc] init];
//    self.wxInstance.viewController = self;
//    self.wxInstance.frame = self.view.frame;
//    __weak typeof(self)weakSelf = self;
//    self.wxInstance.onCreate = ^(UIView *view) {
//        [weakSelf.view addSubview:view];
//    };
//    
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"js"];
//    [self.wxInstance renderWithURL:url options:@{@"bundleUrl":[self.url absoluteString]} data:nil];
    
    
}

- (void)runTimer {
    NSLog(@"runTimer");
}

void *run (void * param){
    NSLog(@"run");
    
    return NULL;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"testNoti" object:nil];
    
}

- (void)practiceBlock {
}

- (void)practiceRunTime {
    //messageForwading
}

- (void)practiceOpt {
    

    
}


- (id)sefePerformAction:(SEL)action target:(NSObject *)target params:(NSDictionary *)params {
    NSMethodSignature *signature = [target methodSignatureForSelector:action];
    if (signature == nil) {
        return nil;
    }
    
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    if (params) {
        [invocation setArgument:&params atIndex:2];
    }
    [invocation setTarget:target];
    [invocation setSelector:action];
    const char *retType = [signature methodReturnType];
    if (strcmp(retType, @encode(void)) == 0) {
        [invocation invoke];
        return nil;
    }
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
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
    
    
    

//
//    dispatch_async(queue, ^{
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        [array addObject:@1];
//        [array addObject:@2];
//        [NSThread sleepForTimeInterval:2];
//        [array addObject:@3];
//        [array addObject:@4];
//        dispatch_semaphore_signal(semaphore);
//        NSLog(@"%@",array);
//    });
//
//    dispatch_async(queue, ^{
//        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        [array addObject:@11];
//        [array addObject:@22];
//        [NSThread sleepForTimeInterval:4];
//        [array addObject:@33];
//        [array addObject:@44];
//        dispatch_semaphore_signal(semaphore);
//        NSLog(@"%@",array);
//    });
//    dispatch_async(queue, ^{
//                dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
//        [array addObject:@111];
//        [array addObject:@222];
//        [NSThread sleepForTimeInterval:6];
//        [array addObject:@333];
//        [array addObject:@444];
//                dispatch_semaphore_signal(semaphore);
//        NSLog(@"%@",array);
//    });
//

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
