//
//  FLRLMCar.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/6/11.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import "FLCarRealmModel.h"

@implementation FLCarRealmModel

- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"<%@: %p> name=%@, price=%f", [self class], self, self.name, self.price];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p> name=%@, price=%f", [self class], self, self.name, self.price];
}

@end
