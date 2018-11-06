//
//  WZDMainViewController.m
//  MyHomeWork
//
//  Created by 王战东 on 16/9/25.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import "WZDMainViewController.h"
#import "WZDCustomView.h"
#import "DHAllOrderModel.h"
#import "DHOrderKind.h"
#import "DHOrderModel.h"

#import "FRCMainViewController.h"
#import <BlocksKit/BlocksKit.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "JSPerson.h"
#define ImageName @"biye"
@interface WZDMainViewController ()

@property (nonatomic, strong) WZDCustomView *customView;
@property (nonatomic, strong) NSMutableDictionary *popTableViewDataDict;
@property (nonatomic, strong) NSMutableArray *popTableViewSectionData;

@property (nonatomic, strong) RACCommand *actionCommand;

@end

@implementation WZDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Home";
    [self.view addSubview:self.customView];
    [self.customView addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    JSContext *context = [[JSContext alloc] init];
    [context evaluateScript:@"var a = 2; var b = 2"];
    NSInteger sum  = [[context evaluateScript:@"a + b"] toInt32];
    NSLog(@"%d",sum);
    
    context[@"globalFunc"] = ^(){
        NSArray *args = [JSContext currentArguments];
        for (id obj in args) {
            NSLog(@"拿到了参数%@",obj);
        }
    };
    context[@"globalProp"] = @"全局变量字符串";
    [context evaluateScript:@"globalFunc(globalProp)"];
    
    JSPerson *person = [JSPerson new];
    context[@"person"] = person;
    person.firstName = @"Di";
    person.secondName = @"Tang";
    [context evaluateScript:@"log(person.fullName())"];

    [person evaluatePrice];
    
    
//    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//        NSLog(@"执行命令");
//        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//            [subscriber sendNext:@"请求数据"];
//            [subscriber sendCompleted];
//            return nil;
//        }];
//    }];
//
//    self.actionCommand = command;
//    [command.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
//    [self.actionCommand execute:@3];
    
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
