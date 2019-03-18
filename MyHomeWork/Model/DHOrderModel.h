//
//  DHOrderModel.h
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/10.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DHOrderKind;
@interface DHOrderModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *orderID;
@property (nonatomic, strong) DHOrderKind *kind;

@property (nonatomic, strong) NSMutableArray *orders;

- (NSMutableArray *)ordersArray;
- (void)removeObjectFromOrdersAtIndex:(NSUInteger)index;
- (void)insertObject:(id)object inOrdersAtIndex:(NSUInteger)index;
- (void)replaceObjectInOrdersAtIndex:(NSUInteger)index withObject:(id)object;

@end
