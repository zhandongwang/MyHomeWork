//
//  WZDMainViewController.m
//  MyHomeWork
//
//  Created by 王战东 on 16/9/25.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import "FLMainViewController.h"
#import "WZDCustomView.h"
#import "DHAllOrderModel.h"
#import "DHOrderKind.h"
#import "DHOrderModel.h"

#import "FRCMainViewController.h"
#import <BlocksKit/BlocksKit.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "JSPerson.h"
#define ImageName @"biye"
#import "FLPerson.h"
#import "FLCar.h"
#import "FLProxy.h"
#import "FLProxyB.h"

@interface FLMainViewController ()

@property (nonatomic, strong) WZDCustomView *customView;
@property (nonatomic, strong) NSMutableDictionary *popTableViewDataDict;
@property (nonatomic, strong) NSMutableArray *popTableViewSectionData;

@property (nonatomic, strong) RACCommand *actionCommand;

@end

@implementation FLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Home";
    [self.view addSubview:self.customView];
    [self.customView addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
//    FLCar *car = [[FLCar alloc] init];
//    [car runTo:@"杭州"];
    NSString *str = @"test";
    FLProxy *proxyA = [FLProxy proxyForObject:str];
    FLProxyB *proxyB = [[FLProxyB alloc] initWithObj:str];
    
    
    
    NSLog(@"%d", [proxyA respondsToSelector:@selector(length)]);
    NSLog(@"%d", [proxyB respondsToSelector:@selector(length)]);
    
    NSLog(@"%d", [proxyA isKindOfClass:[NSString class]]);
    NSLog(@"%d", [proxyB isKindOfClass:[NSString class]]);
    
    
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.customView updateName:@"hello"];
    [[self loginSignal] subscribeNext:^(id  _Nullable x) {
        
    } error:^(NSError * _Nullable error) {
        
    }];
}

- (void)dealloc {
    [self.customView removeObserver:self forKeyPath:@"name"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"name"]) {
        
    }
}
//void blockFunc1()
//{
//    int num = 100;
//    void (^block)() = ^{
//        NSLog(@"num equal %d", num);
//    };
//    num = 200;
//    block();
//}
//void blockFunc2()
//{
//    __block int num = 100;
//    void (^block)() = ^{
//        NSLog(@"num equal %d", num);
//    };
//    num = 200;
//    block();
//}
//// 全局变量
//int num = 100;
//void blockFunc3()
//{
//    void (^block)() = ^{
//        NSLog(@"num equal %d", num);
//    };
//    num = 200;
//    block();
//}
//
//void blockFunc4()
//{
//    static int num = 100;
//    void (^block)() = ^{
//        NSLog(@"num equal %d", num);
//    };
//    num = 200;
//    block();
//}


- (RACSignal *)loginSignal {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"logging in");
        [subscriber sendCompleted];
        return nil;
    }];
}

- (void)testBlock {
//    __block int a = 0;
//    NSLog(@"block定义前%p", &a);
//    void(^foo)(void) = ^{
//        a = 1;
//        NSLog(@"block内部%p", &a);
//    };
//    NSLog(@"block定义后%p", &a);
//    foo();
}

- (void)doWithBlock:(void(^)(NSString *name))block {
    !block?: block(@"hello");
}

- (void)testThread {
    NSInvocationOperation *invocationOperation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocation:) object:@"hello invocationOperation"];
    //    [invocationOperation start];
    
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"blockOperation1 thread:%@",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"blockOperation1 thread:%@",[NSThread currentThread]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"blockOperation1 thread:%@",[NSThread currentThread]);
    }];
    [blockOperation setCompletionBlock:^{
        NSLog(@"blockOperation completed");
    }];
    //    [blockOperation start];
    
    NSOperationQueue *queue = [NSOperationQueue new];
    [queue addOperation:invocationOperation];
    [queue addOperation:blockOperation];
    [queue addOperationWithBlock:^{
        NSLog(@"queueOperationBlock thread:%@",[NSThread currentThread]);
    }];
    
    
    NSLog(@"after invocation");
}

- (void)invocation:(NSString *)params {
    NSLog(@"handler invocationOperation with params:%@",params);
    NSLog(@"invocationOperation thread:%@",[NSThread currentThread]);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [self loadPopViewData];
    
//    [self loadMessageData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnTapped {
//    [self.popTabView showWithSectionData:self.popTableViewSectionData
}


- (void)loadMessageData {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"message" withExtension:@".json"];
    NSData *data = [NSData dataWithContentsOfURL:url];
}


- (void)loadPopViewData {
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"popData" withExtension:@".json"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    

}

- (void)getPreviewContent:(id)data {
    
}


#pragma mark - accessors

- (WZDCustomView *)customView
{
    if (!_customView) {
        _customView = [[WZDCustomView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        _customView.center = self.view.center;
    }
    return _customView;
}

@end
