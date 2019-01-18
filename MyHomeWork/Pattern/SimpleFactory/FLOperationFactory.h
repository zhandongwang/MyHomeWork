//
//  FLOperationFactory.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/1/18.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLOperation.h"

typedef NS_ENUM(NSUInteger, FLOperationType) {
    FLOperationTypeAdd,
    FLOperationTypeSub,
    FLOperationTypeMul,
    FLOperationTypeDiv
};

NS_ASSUME_NONNULL_BEGIN

@interface FLOperationFactory : NSObject

- (FLOperation *)createOperation:(FLOperationType )type;
@end

NS_ASSUME_NONNULL_END
