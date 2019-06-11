//
//  main.m
//  MyHomeWork
//
//  Created by 王战东 on 16/9/25.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#include <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <FBRetainCycleDetector/FBRetainCycleDetector.h>


int main(int argc, char * argv[]) {
    @autoreleasepool {
        [FBAssociationManager hook];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}



