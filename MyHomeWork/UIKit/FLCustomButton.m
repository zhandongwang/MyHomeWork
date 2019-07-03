//
//  FLCustomButton.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/7/1.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import "FLCustomButton.h"

@implementation FLCustomButton


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"=========> FLCustomButton touchs Began");
    [super touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"=========> FLCustomButton touchs Moved");
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"=========> FLCustomButton touchs Ended");
    [super touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"=========> FLCustomButton touchs Cancelled");
}


@end
