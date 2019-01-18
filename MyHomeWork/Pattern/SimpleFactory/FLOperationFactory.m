//
//  FLOperationFactory.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/1/18.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLOperationFactory.h"

@implementation FLOperationFactory

- (FLOperation *)createOperation:(FLOperationType )type {
    switch (type) {
        case FLOperationTypeAdd:
            return [FLOperationAdd new];
        case FLOperationTypeSub:
            return [FLOperationSub new];
        case FLOperationTypeMul:
            return [FLOperationMul new];
        case FLOperationTypeDiv:
            return [FLOperationDiv new];
    }
    return [FLOperation new];
}


@end
