//
//  AppDelegate.h
//  MyHomeWork
//
//  Created by 王战东 on 16/9/25.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Flutter/Flutter.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, FlutterAppLifeCycleProvider>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) FlutterEngine *flutterEngine;


@end

