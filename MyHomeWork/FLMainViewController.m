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
#import "DHOrderDishModel.h"
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

    NSInteger var = 110;
    BOOL bVar = YES;
    if (var > 100) {
        bVar = NO;
    }
    NSLog(@"var now is %d",bVar);
}
    

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
     NSLog(@"监听到%@的%@改变了%@", object, keyPath,change);
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.customView updateName:@"hello"];
    
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber * _Nullable input) {
        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
            NSInteger integer = [input integerValue];
            for (NSInteger i = 0; i < integer; i++) {
                [subscriber sendNext:@(i)];
            }
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    [[command.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@", x);
    }];
    
    [command execute:@1];
//    [RACScheduler.mainThreadScheduler afterDelay:0.1
//                                        schedule:^{
//                                            [command execute:@2];
//                                        }];
//    [RACScheduler.mainThreadScheduler afterDelay:0.2
//                                        schedule:^{
//                                            [command execute:@3];
//                                        }];
    
    
//    self.actionCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
//        RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//            [subscriber sendNext:@"command signal"];
//            [subscriber sendCompleted];
//
//            return nil;
//        }];
//        return signal;
//    }];
    
    
//    [[[[self loginSignal]
//       doNext:^(id  _Nullable x) {
//           NSLog(@"doNext");
//       }]
//        doCompleted:^{
//         NSLog(@"doCompleted");
//        }]
//      subscribeNext:^(id  _Nullable x) {
//          NSLog(@"%@",x);
//      } error:^(NSError * _Nullable error) {
//          NSLog(@"error");
//      }completed:^{
//          NSLog(@"completed");
//      }] ;
    
    
}


- (void)updateWithFirst:(id)x1 second:(id)x2 {
    NSLog(@"%@,%@",x1,x2);
}

- (void)dealloc {
    [self.customView removeObserver:self forKeyPath:@"name"];
}


- (RACSignal *)loginSignal {
    return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//        NSLog(@"logging in");
//        [NSThread sleepForTimeInterval:10];
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        return nil;
    }];
}

- (void)doWithBlock:(void(^)(NSString *name))block {
    !block?: block(@"hello");
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnTapped {
//    FLCar *car = [[FLCar alloc] init];
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [car class];
//    });
    
    [self.actionCommand.executionSignals subscribeNext:^(id  _Nullable x) {
        [x subscribeNext:^(id  _Nullable x) {
             NSLog(@"%@",x);
        }];
        
    }];
    
//    
//    [self.actionCommand.executionSignals.switchToLatest subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@",x);
//    }];
}

#pragma mark - accessors

- (WZDCustomView *)customView
{
    if (!_customView) {
        _customView = [[WZDCustomView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        _customView.center = self.view.center;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"测试" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor yellowColor]];
        button.frame = CGRectMake(50, 50, 50, 20);
        [button addTarget:self action:@selector(btnTapped) forControlEvents:UIControlEventTouchUpInside];
        [_customView addSubview:button];
    }
    return _customView;
}

@end
