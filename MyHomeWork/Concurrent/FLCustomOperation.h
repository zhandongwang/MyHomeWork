//
//  FLOperation.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/7/1.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLCustomOperation : NSOperation

- (instancetype)initWithObject:(id)obj;

@property (nonatomic, copy) id obj;

@end

NS_ASSUME_NONNULL_END
