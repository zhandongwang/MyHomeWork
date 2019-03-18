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
//#import "DHOrderModel.h"

#import "FRCMainViewController.h"
#import <BlocksKit/BlocksKit.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "JSPerson.h"
#define ImageName @"biye"
#import "FLPerson.h"
#import "FLCar.h"
#import "FLProxy.h"
#import "DHOrderDishModel.h"
#import "DHUserModel.h"

@interface FLMainViewController ()<CAAnimationDelegate>

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
    [self.customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(200, 200));
        make.center.equalTo(self.view);
        
    }];
    NSLog(@"%@",self.title);

//    FLProxy *proxy = [FLProxy dealerProxy];
//    [proxy purchaseBookWithTitle:@"hello"];
////    [proxy purchaseCloseWithSize:CGSizeMake(10, 10)];
//    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
//    NSURL *url = [FLProxy proxyForObject:[NSURL URLWithString:@"www.google.com"]];
//    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        [NSThread sleepForTimeInterval:1.5];
//        NSLog(@"URL RESPONSE");
//        dispatch_semaphore_signal(sem);
//    }];
//    [task resume];
//    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
//    NSLog(@"test finished");

}

- (void)viewWillLayoutSubviews {
    NSLog(@"%s",__func__);
    [super viewWillLayoutSubviews];
}

- (void)viewDidLayoutSubviews {
    NSLog(@"%s",__func__);
    [super viewDidLayoutSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.customView setNeedsLayout];
    
    NSDictionary *dict = @{@"age" : @"10000"};
    DHUserModel *user = [DHUserModel yy_modelWithJSON:dict];
    NSLog(@"%ld",user.age);

    
}

- (void)testAnimation {
//    CABasicAnimation *fadeIn = [CABasicAnimation animationWithKeyPath:@"bounds.size.width"];
//    fadeIn.duration = 0.75;
//    fadeIn.fromValue = @100;
//    fadeIn.toValue = @300;
//    fadeIn.removedOnCompletion = NO;
//    fadeIn.fillMode = kCAFillModeForwards;
//
//    [self.customView.layer addAnimation:fadeIn forKey:@"fade in"];
//
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"after animation UIView:%@",self.customView);
//        NSLog(@"after animation UIView.layer.bounds.size.width:%f",self.customView.layer.bounds.size.width);
//    });
    
    CABasicAnimation *zPosition = [CABasicAnimation animation];
    zPosition.keyPath = @"zPosition";
    zPosition.fromValue = @-1;
    zPosition.toValue = @1;
    zPosition.duration = 1.2;
    
    CAKeyframeAnimation *rotation = [CAKeyframeAnimation animation];
    rotation.keyPath = @"rotation.z";
    rotation.values = @[ @0, @0.14, @0 ];
    rotation.duration = 1.2;
    rotation.timingFunctions = @[
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                 ];
    
    CAKeyframeAnimation *position = [CAKeyframeAnimation animation];
    position.keyPath = @"position";
    position.values = @[
                        [NSValue valueWithCGPoint:CGPointZero],
                        [NSValue valueWithCGPoint:CGPointMake(200, 300)]
                        ];
    position.timingFunctions = @[
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                 [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]
                                 ];
//    position.additive = YES;
    position.duration = 1.2;
    
    CAAnimationGroup *group2 = [[CAAnimationGroup alloc] init];
    group2.animations = @[ rotation ];
    group2.duration = 1.2;
//    group2.beginTime = 0.5;
    group2.delegate = self;
    group2.removedOnCompletion = NO;
    
    [self.customView.layer addAnimation:group2 forKey:nil];
    
//    self.customView.layer.zPosition = 1;
    
//    CABasicAnimation *rotate = [CABasicAnimation animation];
//    rotate.keyPath = @"transform.rotation.z";
//    rotate.toValue = @(M_PI);
//
//    CABasicAnimation *scale = [CABasicAnimation animation];
//    scale.keyPath = @"transform.scale";
//    scale.toValue = @(10);
//
//    CABasicAnimation *move = [CABasicAnimation animation];
//    move.keyPath = @"transform.translation.z";
//    move.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 300)];
//
//    CAAnimationGroup *group = [ CAAnimationGroup animation];
//    group.animations = @[scale];
//    group.duration = 2.0;
//    group.removedOnCompletion = NO;
//    group.fillMode = kCAFillModeForwards;
//    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
//
//    group.delegate = self;
//
//    [self.customView.layer addAnimation:group forKey:nil];
    
    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:1.0f];
//    self.customView.frame = CGRectMake(0, 100, 50, 50);
//    [UIView commitAnimations];
    
}


- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"animationDidStart");
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"animationDidStop");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
     NSLog(@"监听到%@的%@改变了%@", object, keyPath,change);
}


//- (void)viewDidAppear:(BOOL)animated{
//    [super viewDidAppear:animated];
//    [self.customView updateName:@"hello"];
//
//    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(NSNumber * _Nullable input) {
//        return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
//            NSInteger integer = [input integerValue];
//            for (NSInteger i = 0; i < integer; i++) {
//                [subscriber sendNext:@(i)];
//            }
//            [subscriber sendCompleted];
//            return nil;
//        }];
//    }];
//    [[command.executionSignals switchToLatest] subscribeNext:^(id  _Nullable x) {
//        NSLog(@"%@", x);
//    }];
//
//    [command execute:@1];
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
    
    
//}


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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)btnTapped {
    [self testAnimation];
}

#pragma mark - accessors

- (WZDCustomView *)customView
{
    if (!_customView) {
        _customView = [[WZDCustomView alloc] init];
        _customView.backgroundColor = [UIColor yellowColor];
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button setTitle:@"测试" forState:UIControlStateNormal];
//        [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//        [button setBackgroundColor:[UIColor yellowColor]];
//        button.frame = CGRectMake(50, 50, 50, 20);
//        [button addTarget:self action:@selector(btnTapped) forControlEvents:UIControlEventTouchUpInside];
//        [_customView addSubview:button];
    }
    return _customView;
}

@end
