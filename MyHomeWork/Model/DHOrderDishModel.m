//
//  DHOrderDishModel.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/1/9.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "DHOrderDishModel.h"

@implementation DHOrderDishModel
//+ (void)load {
//    NSLog(@"DHOrderDishModel load");
//}
//+ (void)initialize {
//    NSLog(@"DHOrderDishModel initialize");
//}
//
//- (void)printName {
//    NSLog(@"printName--DHOrderDishModel");
//}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"%@",NSStringFromClass([self class]));
        NSLog(@"%@",NSStringFromClass([super class]));
    }
    return self;
}


@end
