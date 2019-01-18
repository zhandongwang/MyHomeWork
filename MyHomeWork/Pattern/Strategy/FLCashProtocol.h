//
//  FLCashProtocol.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/1/18.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef FLCashProtocol_h
#define FLCashProtocol_h

@protocol FLCashProtocol <NSObject>
@required
- (CGFloat)acceptCash:(CGFloat) money;

@end

#endif /* FLCashProtocol_h */
