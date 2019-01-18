//
//  FLOperation.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/1/18.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLOperation : NSObject

@property (nonatomic, assign) CGFloat numberA;
@property (nonatomic, assign) CGFloat numberB;

-(CGFloat)getResult;

@end


@interface FLOperationAdd : FLOperation

@end

@interface FLOperationSub : FLOperation

@end

@interface FLOperationMul : FLOperation

@end


@interface FLOperationDiv : FLOperation

@end

NS_ASSUME_NONNULL_END
