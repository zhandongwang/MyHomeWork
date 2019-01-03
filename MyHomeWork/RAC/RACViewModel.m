//
//  RACViewModel.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/1/2.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "RACViewModel.h"
#import "RACRequest.h"

@implementation RACViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        RACSignal *userNameLengthSig = [RACObserve(self, userName) map:^id _Nullable(NSString * value) {
            if (value.length > 6) {
                return @(YES);
            }
            return @(NO);
        }];
        RACSignal *passwordLengthSig = [RACObserve(self, password) map:^id _Nullable(NSString * value) {
            if (value.length > 6) {
                return @(YES);
            }
            return @(NO);
        }];
        
        RACSignal *loginSignal = [RACSignal combineLatest:@[userNameLengthSig, passwordLengthSig] reduce:^id(NSNumber *userName, NSNumber *password){
            return @([userName boolValue] && [password boolValue]);
        }];
        _loginCommand = [[RACCommand alloc] initWithEnabled:loginSignal signalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACRequest loginWithUserName:self.userName password:self.password];
        }];
        
    }
    return self;
}

@end
