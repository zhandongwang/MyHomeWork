//
//  FLProxyB.m
//  MyHomeWork
//
//  Created by 凤梨 on 2018/11/8.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

#import "FLProxyB.h"

@interface FLProxyB ()

@property (nonatomic, strong) id target;

@end

@implementation FLProxyB


- (instancetype)initWithObj:(id)obj
{
    self = [super init];
    if (self) {
        self.target = obj;
    }
    return self;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [self.target methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation invokeWithTarget:self.target];
}


@end
