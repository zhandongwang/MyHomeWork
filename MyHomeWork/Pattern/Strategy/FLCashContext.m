//
//  FLCashContext.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/1/18.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLCashContext.h"
@interface FLCashContext ()

@property (nonatomic, strong)id <FLCashProtocol>cash;

@end

@implementation FLCashContext

- (instancetype)initWithCash:(id <FLCashProtocol>)cash
{
    self = [super init];
    if (self) {
        self.cash = cash;
    }
    return self;
}

- (CGFloat)getResult:(CGFloat)money {
    if ([self.cash respondsToSelector:@selector(acceptCash:)]) {
        return [self.cash acceptCash:money];
    }
    return money;
}

@end
