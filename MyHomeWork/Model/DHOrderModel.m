//
//  DHOrderModel.m
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/10.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import "DHOrderModel.h"
#import "DHOrderKind.h"

@implementation DHOrderModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.kind = [[DHOrderKind alloc] init];
        self.kind.title = @"first";
        self.kind.isOld = NO;
    }
    return self;
}
//- (NSInteger)countOfOrderArray {
//    return self.count;
//}
//
//- (id)objectInOrderArrayAtIndex:(NSUInteger)index {
//    return [NSString stringWithFormat:@"%@_%ld",self.name, index];
//}

- (NSMutableArray *)ordersArray {
    return [self mutableArrayValueForKey:NSStringFromSelector(@selector(orders))];
}

- (void)insertObject:(id )object inOrdersAtIndex:(NSUInteger)index {
    [self.orders insertObject:object atIndex:index];
}

- (void)removeObjectFromOrdersAtIndex:(NSUInteger)index {
    [self.orders removeObjectAtIndex:index];
}

- (void)replaceObjectInOrdersAtIndex:(NSUInteger)index withObject:(id)object {
    [self.orders replaceObjectAtIndex:index withObject:object];
}

@end
