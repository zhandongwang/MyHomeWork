//
//  AppDelegate.m
//  MyHomeWork
//
//  Created by 王战东 on 16/9/25.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import "AppDelegate.h"
#import "MyHomeWork-Swift.h"
#import "FLTableViewController.h"
#import "PLeakSniffer.h"
#import <coobjc/coobjc.h>
#import <ReactiveObjC/ReactiveObjC.h>


@interface AppDelegate ()

@end

@implementation AppDelegate {
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [self setupMemoryCheck];
    
    [[PLeakSniffer sharedInstance] installLeakSniffer];
    [[PLeakSniffer sharedInstance] alertLeaks];
    
    
//    _memoryProfiler = [[FBMemoryProfiler alloc] initWithPlugins:@[[CacheCleanerPlugin new],
//                                                                  [RetainCycleLoggerPlugin new]]
//                               retainCycleDetectorConfiguration:nil];
//    _memoryProfiler = [FBMemoryProfiler new];
//    [_memoryProfiler enable];
    
    
    FLTableViewController  *vc = [[FLTableViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
    self.window.rootViewController = navigationController;
    self.window.backgroundColor = [UIColor whiteColor];

    [self.window makeKeyAndVisible];
    
    
    return YES;
}
/*
- (void)setupMemoryCheck {
    OOMDetector *detector = [OOMDetector getInstance];
    // 设置捕获堆栈数据、内存log代理，在出现单次大块内存分配、检查到内存泄漏时、调用uploadAllStack方法时会触发此回调
    [detector setFileDataDelegate:[OOMDataManager getInstance]];
    // 设置app内存触顶监控数据代理，在调用startMaxMemoryStatistic:开启内存触顶监控后会触发此回调，返回前一次app运行时单次生命周期内的最大物理内存数据
    [detector setPerformanceDataDelegate:[OOMDataManager getInstance]];
    [detector setupWithDefaultConfig];
    
    // 单次大块内存分配监控
    [detector startSingleChunkMallocDetector:50 * 1024 * 1024 callback:^(size_t bytes, NSString *stack) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:kChunkMallocNoti object:stack];
    }];
    
    // 开启内存泄漏监控
//    [detector setupLeakChecker];
    [detector uploadAllStack];
    
}
 */


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
