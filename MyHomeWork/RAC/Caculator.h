//
//  Caculator.h
//  MyHomeWork
//
//  Created by 凤梨 on 2017/8/3.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Caculator : NSObject

@property (nonatomic, assign) BOOL isEqule;
@property (nonatomic, assign) int result;

- (Caculator *)caculator:(int(^)(int result))caculator;
- (Caculator *)equle:(BOOL(^)(int result))operation;

@end
