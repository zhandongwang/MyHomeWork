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
#import "testStaticLib.h"
#import <Realm/Realm.h>
#import "CustomRlmDog.h"
#import "CustomRlmPerson.h"
#import "Aspects.h"
#import "JPEngine.h"
#import "MyPageRouter.h"
#import "MyPageNavigator.h"


#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface WZDMainViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIView *customView;
@property (nonatomic, strong) UIButton *customButton;

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *context;

@property (nonatomic, strong) NSLock *lock;
@property (nonatomic, copy) NSString *rwStr;
@property (nonatomic, strong) dispatch_queue_t defaultQueue;
@property (nonatomic, strong) dispatch_queue_t customQueue;

@end


@implementation WZDMainViewController
{
    pthread_rwlock_t _rwLock;//读写锁
}

+ (void)load
{
    [[MyPageRouter router] registerUrl:@"bb/forum/audio_player" toControllerClass:[self class]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    [self.view addSubview:self.webView];
//    
//    NSURL *url = [[NSBundle mainBundle] URLForResource:@"test" withExtension:@"html"];
//    [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
//    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(jsContextCreated:) name:@"didCreateJsContextNotification" object:nil];
    
//    [self testRecursiveLock];
//    [self testRWLock];
//    [self testThreadSync];
//    [self testConditionLock];
//    [self testRealm];
//    [self testJsPatch];
    
//    testStaticLib *testObj = [testStaticLib new];
//    [testObj testLog:@"hello static lib"];
    
    [self.view addSubview:self.customButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testJsPatch
{
    [JPEngine startEngine];
    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"JsDemo" ofType:@"js"];
    NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
    [JPEngine evaluateScript:script];
    [self.view addSubview:[self genView]];
}

- (UIView *)genView
{
    return [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 320)];
}


#pragma mark - Thread Synchronize

- (void)testSemaphore
{
    self.defaultQueue = dispatch_queue_create("com.wze.queue", DISPATCH_QUEUE_CONCURRENT); //dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
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

#pragma mark - Realm

- (void)testRealm
{
    CustomRlmDog *myDog = [CustomRlmDog new];
    myDog.name = @"大黄";
    myDog.age = 10;
    
    CustomRlmDog *myOtherDog = [[CustomRlmDog alloc] initWithValue:@{@"name":@"豆豆",@"age":@3}];
    CustomRlmDog *myThridDog = [[CustomRlmDog alloc] initWithValue:@[@"毛毛",@3]];
    CustomRlmPerson *person1 = [[CustomRlmPerson alloc] initWithValue:@[@"李四",@30,@[myDog, myOtherDog]]];
    CustomRlmPerson *person2 = [[CustomRlmPerson alloc] initWithValue:@[@"李四",@30,@[@[@"小黑",@5],@[@"旺财",@6]]]];
    
    RLMRealm *realm = [RLMRealm defaultRealm];
    RLMResults <CustomRlmDog *> *dogs = [CustomRlmDog allObjects];
    [realm transactionWithBlock:^{
        [[dogs firstObject] setValue:@"大黄" forKey:@"name"];
    }];
    
    for (CustomRlmDog *dog in dogs) {
        NSString *name = dog.name;
        NSLog(@"%@",name);
    }
    
}


- (void)addDog:(CustomRlmDog *)dog
{
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm transactionWithBlock:^{
        [realm addObject:dog];
    }];
}

#pragma mark - Lock

- (void)testSimpleLock
{
    self.lock = [[NSLock alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.lock lock];//获取锁
        NSLog(@"-----thread 1 ----");
        sleep(10);
        [self.lock unlock];//释放锁
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        [self.lock lock];
        NSLog(@"-----thread 2 ----");
        [self.lock unlock];

    });
}

- (void)testConditionLock
{
    NSConditionLock *conditionLock = [[NSConditionLock alloc] init];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i <= 2; i++) {
            [conditionLock lock];//获取锁
            NSLog(@"thread :%d",i);
            sleep(2);
            [conditionLock unlockWithCondition:i];//释放锁
        }
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [conditionLock lockWhenCondition:2];
        NSLog(@"thread 2");
        [conditionLock unlock];
    });
}

- (void)readWriteLock
{
    self.customQueue = dispatch_queue_create("com.queue.custom", DISPATCH_QUEUE_CONCURRENT);
}

- (void)modifyRwStr:(NSString *)newStr
{
    dispatch_barrier_async(self.customQueue, ^{
        self.rwStr = newStr;
    });
}

- (NSString *)readString
{
    __block NSString *string;
    dispatch_sync(self.customQueue, ^{
        string = self.rwStr;
    });
    return string;
}

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
            [recursiveLock lock];//获取锁
            if (value > 0) {
                NSLog(@"value = %d",value);
                RecursiveLockBlock(value - 1);
            }
            [recursiveLock unlock];//释放锁
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

- (void)buttonTapped
{
//    UILocalNotification *localNote = [[UILocalNotification alloc] init];
//    localNote.fireDate = [NSDate dateWithTimeIntervalSinceNow:5];
//    localNote.alertBody  = @"回来了";
//    localNote.alertAction = @"查看具体消息";
//    localNote.hasAction = YES;
//    localNote.alertTitle = @"标题党";
//    localNote.applicationIconBadgeNumber = 1;
//    localNote.userInfo = @{@"name":@"lily", @"toName":@"liyang"};
//    [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
    [[MyPageNavigator navigator] pushViewControllerByUrl:@"bb/forum/audio_player" animated:YES];
    
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
    }
    return _customView;
}

- (UIButton *)customButton
{
    if (!_customButton) {
        _customButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 100, 30)];
        [_customButton setTitle:@"本地通知" forState:UIControlStateNormal];
        [_customButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        _customButton.backgroundColor = [UIColor blueColor];
        [_customButton addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
    }
    return _customButton;
}

@end
