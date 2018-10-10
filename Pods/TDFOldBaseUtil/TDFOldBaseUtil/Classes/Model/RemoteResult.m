//
//  RemoteResult.m
//  RestApp
//
//  Created by zxh on 14-4-15.
//  Copyright (c) 2014年 杭州迪火科技有限公司. All rights reserved.
//

#import "RemoteResult.h"

@implementation RemoteResult

 -(id)initSuccessStatus
{
    self = [super init];
    if (self) {
        self.isSuccess = YES;
    }
    return self;
}

@end
