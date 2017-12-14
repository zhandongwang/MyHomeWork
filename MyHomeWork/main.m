//
//  main.m
//  MyHomeWork
//
//  Created by 王战东 on 16/9/25.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

//#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int global_i = 1;
static int static_global_j = 2;

int main(int argc, char * argv[]) {
    @autoreleasepool {
//        static int static_k = 3;
//        int val = 4;
//        void(^myBlock)(void) = ^{
//            global_i++;
//            static_global_j++;
//            static_k++;
////            NSLog(@"Block中 global_i=%d,static_global_j=%d,static_k=%d",global_i,static_global_j,static_k);
//        };
//        global_i++;
//        static_global_j++;
//        static_k++;
//        val++;
//        NSLog(@"Block外 global_i=%d,static_global_j=%d,static_k=%d,val=%d",global_i,static_global_j,static_k,val);
//        NSLog(@"%@",myBlock);
//        myBlock();
//        NSMutableString *str = [[NSMutableString alloc] initWithString:@"hello"];
//        void(^myBlock)(void)=^{
//            [str appendString:@"world"];
//            NSLog(@"Block中str=%@",str);
//        };
//        NSLog(@"Block外str=%@",str);
//        myBlock();
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
