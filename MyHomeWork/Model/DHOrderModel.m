//
//  DHOrderModel.m
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/10.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import "DHOrderModel.h"
#import "DHOrderKind.h"

@interface DHOrderModel ()

@property(nonatomic, copy) void(^blockOne)(NSString *str);

@end

@implementation DHOrderModel{
    NSString *_orderName;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.kind = [[DHOrderKind alloc] init];
        self.kind.title = @"first";
        self.kind.isOld = NO;
        [self testBlock];
    }
    return self;
}
- (void)testBlock {
    _orderName = @"hello";
    self.blockOne = ^(NSString *str) {
        _orderName = str;
    };
    self.blockOne(@"world");
}

- (void)dealloc
{
    NSLog(@"%s",__PRETTY_FUNCTION__);
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
