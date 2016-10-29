//
//  WZDMainViewController.m
//  MyHomeWork
//
//  Created by 王战东 on 16/9/25.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import "WZDMainViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "JSCoreObject.h"
#import "SubClass.h"
#import <pthread.h>

@interface WZDMainViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIView *customView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *context;

@property (nonatomic, strong) NSLock *lock;
@property (nonatomic, copy) NSString *rwStr;
@property (nonatomic, strong) dispatch_queue_t defaultQueue;

@end

@implementation WZDMainViewController
{
    pthread_rwlock_t _rwLock;//读写锁
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view addSubview:self.webView];
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jsContextCreated:) name:@"didCreateJsContextNotification" object:nil];
    
    self.defaultQueue = dispatch_queue_create("com.wze.queue", DISPATCH_QUEUE_CONCURRENT); //dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    
//    [self testRecursiveLock];
//    [self testRWLock];
    [self testThreadSync];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Thread Synchronize

- (void)testThreadSync
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    __block NSString *strTest = @"test";
    dispatch_async(self.defaultQueue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        if ([strTest isEqualToString:@"test"]) {
            NSLog(@"--%@--1-", strTest);
            [NSThread sleepForTimeInterval:1];
            if ([strTest isEqualToString:@"test"]) {
                [NSThread sleepForTimeInterval:1];
                NSLog(@"--%@--2-", strTest);
            } else {
                NSLog(@"====strTest changed===");
            }
        }
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_async(self.defaultQueue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"--%@--3-", strTest);
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_async(self.defaultQueue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        strTest = @"modify";
        NSLog(@"--%@--4-", strTest);
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_async(self.defaultQueue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"--%@--5-", strTest);
        dispatch_semaphore_signal(semaphore);
    });
    
}

#pragma mark - TestLock

- (void)testRWLock
{
    pthread_rwlock_init(&_rwLock, NULL);//初始化读写锁
    __block int i;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        i = 100;
        while (i >= 0) {
            NSString *temp = [NSString stringWithFormat:@"writting == %d", i];
            [self writingLock:temp];
            i--;
        }
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        i = 100;
        while (i >= 0) {
            [self readingLock];
            i--;
        }
        
    });
}

- (void)writingLock:(NSString *)temp
{
    pthread_rwlock_wrlock(&_rwLock);//写加锁
    self.rwStr = temp;
    NSLog(@"%@",temp);
    pthread_rwlock_unlock(&_rwLock);
}

- (NSString *)readingLock
{
    pthread_rwlock_rdlock(&_rwLock);//读加锁
    NSString *str = self.rwStr;
    NSLog(@"reading == %@",self.rwStr);
    pthread_rwlock_unlock(&_rwLock);
    return str;
}


- (void)testRecursiveLock
{
    NSRecursiveLock *recursiveLock  = [[NSRecursiveLock alloc] init];//递归锁
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        static void(^RecursiveLockBlock)(int value);
        RecursiveLockBlock = ^(int value){
            [recursiveLock lock];
            if (value > 0) {
                NSLog(@"value = %d",value);
                RecursiveLockBlock(value - 1);
            }
            [recursiveLock unlock];
        };
        
        RecursiveLockBlock(10);
    });
}

#pragma mark - TestJs

- (void)jsContextCreated:(NSNotification *)notification
{
    JSContext *context = notification.object;
    
    NSString *indentifier = [NSString stringWithFormat:@"indentifier%lud", (unsigned long)self.webView.hash];
    NSString *indentifierJS = [NSString stringWithFormat:@"var %@ = '%@'", indentifier, indentifier];
    
    [self.webView stringByEvaluatingJavaScriptFromString:indentifierJS];
    
    if (![context[indentifier].toString isEqualToString:indentifier]) {
      return;
    }

    self.context = context;
    JSCoreObject *jsObject = [[JSCoreObject alloc] initWithWebView:self.webView];
    self.context[@"JSTest"] = jsObject;
}

#pragma mark - accessors

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(100, 100, 250, 400)];
        _webView.delegate = self;
    }
    return _webView;
}

- (UIView *)customView
{
    if (!_customView) {
        _customView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        _customView.backgroundColor = [UIColor redColor];
    }
    return _customView;
}

@end
