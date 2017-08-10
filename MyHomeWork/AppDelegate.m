//
//  AppDelegate.m
//  MyHomeWork
//
//  Created by 王战东 on 16/9/25.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import "AppDelegate.h"
#import "WZDMainViewController.h"
#import "NSObject+Caculator.h"
#import "CaculatorMaker.h"
#import "Caculator.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface AppDelegate ()

@property (nonatomic, strong) RACCommand *loginCommand;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    WZDMainViewController *vc = [[WZDMainViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self testRAC];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)testRAC {
    //    int result = [NSObject makeCaculators:^(CaculatorMaker *make) {
    //        make.add(1).add(2);
    //    }];
    //    NSLog(@"%d",result);
    //    Caculator *c = [Caculator new];
    //    BOOL isEqual = [[[c caculator:^(int result) {
    //        result += 2;
    //        result *= 5;
    //        return result;
    //    }] equle:^BOOL(int result) {
    //        return result == 10;
    //    }] isEqule];
    //    NSLog(@"%d",isEqual);
    
//        RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//            [subscriber sendNext:@1];
//            return nil;
//        }];
//        RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//            [subscriber sendNext:@2];
//            return nil;
//        }];
//    
//    RACSignal *combieSignal = [RACSignal combineLatest:@[signalA,signalB] reduce:^id(NSNumber *num1, NSNumber *num2){
//        return [NSString stringWithFormat:@"%@--%@",num1,num2];
//    }];
//    [combieSignal subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
    RACSubject *subject = [RACSubject subject];
//    [subject subscribeNext:^(id x) {
//        NSLog(@"1111%@",x);
//    }];
//    [subject subscribeNext:^(id x) {
//        NSLog(@"2222%@",x);
//    }];
//    [subject sendNext:@1];
//    [[subject skip:2] subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
//    
//    [subject sendNext:@1];
//    [subject sendNext:@2];
//    [subject sendNext:@3];
//    [subject sendNext:@4];
    
    
//        RACSignal *mergeSignal = [signalA merge: signalB];
//        [mergeSignal subscribeNext:^(id x) {
//            NSLog(@"%@",x);
//        }];
    
//    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        [subscriber sendNext:@1];
//        [subscriber sendCompleted];
//        return nil;
//    }] then:^RACSignal *{
//        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//            [subscriber sendNext:@2];
//            return nil;
//        }];
//    }] subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];

//    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        NSLog(@"发出请求");
//        [subscriber sendNext:@1];
//        return nil;
//    }];
//    
//    RACMulticastConnection *connect = [signal publish];
//    [connect.signal subscribeNext:^(id x) {
//        NSLog(@"订阅一次信号");
//    }];
//    [connect.signal subscribeNext:^(id x) {
//        NSLog(@"订阅二次信号");
//    }];
    
//    [connect connect];

//    [[[RACSignal  createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//        [subscriber sendNext:@1];
//        [subscriber sendCompleted];
//        return nil;
//    }] then:^RACSignal *{
//        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//            [subscriber sendNext:@2];
//            return nil;
//        }];
//    }] subscribeNext:^(id x) {
//        NSLog(@"%@",x);
//    }];
   
   
//    RACSubject *signalOfSignals = [RACSubject subject];
//    RACSubject *signal = [RACSubject subject];
//    RACSubject *signal2 = [RACSubject subject];
//    [signalOfSignals.switchToLatest subscribeNext:^(id x) {
//       NSLog(@"%@",x);
//    }];
//    [signalOfSignals sendNext:signal];
//    [signalOfSignals sendNext:signal2];
//    
//    [signal sendNext:@1];
//    [signal2 sendNext:@2];
    
//    self.loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
//        NSLog(@"点击了登录");
//        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                [subscriber sendNext:@"用户名*hhhh"];
//                [subscriber sendCompleted];
//            });
//            return nil;
//        }];
//    }];
//    //监听数据
//    [self.loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
//        NSLog(@"登录数据:%@",x);
//    }];
//    //监听状态
//    [[self.loginCommand.executing skip:1] subscribeNext:^(id x) {
//        if ([x boolValue]) {
//            NSLog(@"执行中。。。");
//        } else {
//            NSLog(@"执行完成");
//        }
//    }];
//    [self.loginCommand execute:@111];

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
