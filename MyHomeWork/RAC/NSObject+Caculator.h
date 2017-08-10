//
//  NSObject+Caculator.h
//  MyHomeWork
//
//  Created by 凤梨 on 2017/8/3.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CaculatorMaker;

@interface NSObject (Caculator)

+ (int)makeCaculators:(void(^)(CaculatorMaker *make))caculatorMaker;

@end
