//
//  FLLayer.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/2/11.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLLayer.h"

@implementation FLLayer

- (void)addAnimation:(CAAnimation *)anim forKey:(nullable NSString *)key {
    NSLog(@"adding animation:%@",[anim debugDescription]);
    [super addAnimation:anim forKey:key];
}


@end
