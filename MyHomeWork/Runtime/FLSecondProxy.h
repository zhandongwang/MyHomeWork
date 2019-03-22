//
//  FLSecondProxy.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/3/21.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLSecondProxy : NSProxy {
    id target1;
    id target2;
}

- (id)initWithTarge1:(id)t1  target2:(id)t2;

@end

NS_ASSUME_NONNULL_END
