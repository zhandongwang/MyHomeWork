//
//  FLCashContext.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/1/18.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCashProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLCashContext : NSObject

- (instancetype)initWithCash:(id <FLCashProtocol>)cash;
- (CGFloat)getResult:(CGFloat)money;
@end

NS_ASSUME_NONNULL_END
