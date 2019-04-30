//
//  AppDelegate.m
//  MyHomeWork
//
//  Created by 王战东 on 16/9/25.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import "AppDelegate.h"
#import "FLMainViewController.h"
#import "RACViewController.h"
#import "FLWebViewController.h"
#import "FRCMainViewController.h"
#import "FLChildViewController.h"
#import "DHOrderModel.h"
#import "MyHomeWork-Swift.h"
#import "ResultModel.h"
#import <WeexSDK/WeexSDK.h>
#import <AFNetworking/AFNetworking.h>
#import <YYModel/YYModel.h>
#import "FLCollectionViewController.h"
#import "FLTableViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) DHOrderModel *order;
@property (nonatomic, assign) NSInteger count;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/plain",@"text/html", nil]];
//    [manager.requestSerializer setStringEncoding:NSUTF8StringEncoding];
//
//    [manager GET:@"https://suggest.taobao.com/sug?code=utf-8&q=iphone" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        if ([responseObject isKindOfClass:[NSDictionary class]]) {
//         ResultModel *model = [ResultModel yy_modelWithDictionary:responseObject];
//
//            for (NSArray *itemArray in model.result) {
//                NSLog(@"%@",itemArray);
//            }
//        }
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"%@",error.description);
//    }];
//
    
    
//    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"https://suggest.taobao.com/sug?code=utf-8&q=iphone"]completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
//        ResultModel *model = [[ResultModel alloc] init];
//        model.result = dict[@"result"];
//
//        for (NSArray *itemArray in model.result) {
//            NSLog(@"%@",itemArray);
//        }
//
//
//    }];
//    [task resume];
    
    
    
    
    FLTableViewController  *vc = [[FLTableViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navigationController;
    self.window.backgroundColor = [UIColor whiteColor];

    [self.window makeKeyAndVisible];
    
    
    return YES;
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
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     [NSThread sleepForTimeInterval:3];
     if (self.count & 1) {
         self.order.name = @"2";
         NSLog(@"%@",self.order.name);
     } else {
         self.order.name = nil;
     }
     self.count++;
     
 });
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
