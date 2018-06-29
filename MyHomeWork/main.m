//
//  main.m
//  MyHomeWork
//
//  Created by 王战东 on 16/9/25.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//
@import Foundation;
#import "AppDelegate.h"
void blockFunc1()
{
    int num = 100;
    void (^block)() = ^{
//        NSLog(@"num equal %d", num);
    };
    num = 200;
    block();
}
void blockFunc2()
{
    __block int num = 100;
    void (^block)() = ^{
//        NSLog(@"num equal %d", num);
    };
    num = 200;
    block();
}

void blockFunc11()
{
    NSString *str = @"100";
    void (^block)() = ^{
        NSLog(@"str equal %@", str);
    };
    str = @"200";
    block();
}
void blockFunc22()
{
    __block NSString *str = @"100";
    void (^block)() = ^{
        str = @"300";
        NSLog(@"str equal %@", str);
    };
    str = @"200";
    block();
}


// 全局变量
int num = 100;
void blockFunc3()
{
    void (^block)() = ^{
//        NSLog(@"num equal %d", num);
    };
    num = 200;
    block();
}

void blockFunc4()
{
    static int num = 100;
    void (^block)() = ^{
//        NSLog(@"num equal %d", num);
    };
    num = 200;
    block();
}

int main(int argc, char * argv[]) {
    @autoreleasepool {
        blockFunc11();
        blockFunc22();
//        return 0;
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
