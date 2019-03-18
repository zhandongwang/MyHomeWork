//
//  DHOrderKind.m
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/10.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import "DHOrderKind.h"
#import "DHOrderModel.h"

@implementation DHOrderKind

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"orders":[DHOrderModel class]
             };
}

- (void)changeTitle:(NSString *)str {
    self.title = str;
}

- (void)changeOld:(BOOL)status {
    self.isOld = status;
}

@end
