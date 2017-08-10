//
//  NSObject+Caculator.m
//  MyHomeWork
//
//  Created by 凤梨 on 2017/8/3.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import "NSObject+Caculator.h"
#import "CaculatorMaker.h"

@implementation NSObject (Caculator)

+ (int)makeCaculators:(void(^)(CaculatorMaker *make))caculatorMaker {
    CaculatorMaker *mk = [CaculatorMaker new];
    caculatorMaker(mk);
    
    return mk.result;
}

@end
