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

#define ImageName @"biye"
@interface WZDMainViewController ()<JSObjcDelegate, UIWebViewDelegate>

@property (nonatomic, strong) WZDCustomView *customView;
@property (nonatomic, strong) JSContext *jsContext;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSMutableDictionary *popTableViewDataDict;
@property (nonatomic, strong) NSMutableArray *popTableViewSectionData;

@property (nonatomic, strong) UIButton *actionButton;
@property (nonatomic, strong) RACCommand *actionCommand;

@end

@implementation WZDMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Home";
    [self.view addSubview:self.customView];
    [self.customView addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
//    [self.view addSubview:self.webView];
//    NSURL *url = [NSURL URLWithString:@"http://d.2dfire-pre.com/hercules/page/guide.html?allowBack=true&isInstallShopkeeperApp=false&pageIndex=1&version=4746&deviceType=1&industryType=3&language=en#/index"];
////    NSURL *url = [[NSBundle mainBundle] URLForResource:@"testWeb" withExtension:@"html"];
//    [self.webView loadRequest:[[NSURLRequest alloc] initWithURL:url]];
    
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
    
    [[[[RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        
        return nil;
    }] doNext:^(id  _Nullable x) {
        NSLog(@"doNext");
    }] doCompleted:^{
        NSLog(@"doCompleted");
    }] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.customView updateName:@"hello"];
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

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
//    NSString *url = request.URL.absoluteString;
//    if ([url rangeOfString:@"toyun://"].location != NSNotFound) {
//        // url的协议头是Toyun
//        NSLog(@"callCamera");
//        return NO;
//    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    self.jsContext[@"cloudCashierGreenHand"] = self;
    self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue) {
        context.exception = exceptionValue;
        NSLog(@"异常:%@", exceptionValue);
    };
    
}

- (void)callCamera {
    NSLog(@"Objc callCamera");//JS调用Native
    JSValue *picCallBack = self.jsContext[@"picCallback"];//回调
    [picCallBack callWithArguments:@[@"photos"]];
}

- (void)share:(NSString *)shareString {
    NSLog(@"Objc share:%@", shareString);
    JSValue *shareCallBack = self.jsContext[@"shareCallback"];
    [shareCallBack callWithArguments:nil];
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

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame)-64)];
        _webView.delegate = self;
    }
    return _webView;
}
- (UIButton *)actionButton {
    if (!_actionButton) {
        _actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_actionButton setTitle:NSLocalizedString(@"CallCamera",@"") forState:UIControlStateNormal];
        [_actionButton setBackgroundColor:[UIColor greenColor]];
    }
    return _actionButton;
}

@end
