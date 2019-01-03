//
//  RACRequest.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/1/2.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "RACRequest.h"

@implementation RACRequest

+ (RACSignal *)loginWithUserName:(NSString *)name password:(NSString *)password
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:[NSString stringWithFormat:@"User %@, password %@, login!",name, password]];
            [subscriber sendCompleted];
        });
        return nil;
    }];
}
@end
