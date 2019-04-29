//
//  DHUserModel.m
//  MyHomeWork
//
//  Created by 凤梨 on 2018/9/25.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

#import "DHUserModel.h"

@implementation DHUserModel
- (instancetype)init
{
    self = [super init];
    if (self) {
//        @throw [NSException exceptionWithName:@"DHUserModel init error" reason:@"noting" userInfo:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNoti:) name:@"testNoti" object:nil];
    }
    return self;
}
- (void)receivedNoti:(NSNotification* )noti{
    NSLog(@"DHUserModel --%s",__FUNCTION__);
}

- (void)runTo:(NSString *)place {
    NSLog(@"User Run %@", place);
}

@end
