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
    
    CAKeyframeAnimation *anima = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    NSValue *value0 = [NSValue valueWithCGPoint:CGPointMake(0, SCREEN_HEIGHT/2-50)];
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2-50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/3, SCREEN_HEIGHT/2+50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2+50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH*2/3, SCREEN_HEIGHT/2-50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH, SCREEN_HEIGHT/2-50)];
    anima.values = [NSArray arrayWithObjects:value0,value1,value2,value3,value4,value5, nil];
    anima.duration = 2.0f;
    anima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];//设置动画的节奏
    anima.delegate = self;//设置代理，可以检测动画的开始和结束
    [self.customView.layer addAnimation:anima forKey:nil];
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
    [self testAnimation];
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
