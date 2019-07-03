//
//  FLOperation.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/7/1.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import "FLCustomOperation.h"

@implementation FLCustomOperation


- (instancetype)initWithObject:(id)obj
{
    if (self = [super init])
    {
        self.obj = obj;
    }
    return self;
}


- (void)main {
    for (int i = 0; i < 100; i++)
    {
        NSLog(@"Task %@ %d %@", self.obj, i, [NSThread currentThread]);
    }
    NSLog(@"Task Complete!");
}




@end
