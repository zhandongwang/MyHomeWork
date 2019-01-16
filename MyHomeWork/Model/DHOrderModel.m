//
//  DHOrderModel.m
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/10.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import "DHOrderModel.h"

@implementation DHOrderModel

+ (void)load {
        NSLog(@"DHOrderModel load");
    }
+ (void)initialize {
    NSLog(@"DHOrderModel initialize");
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
