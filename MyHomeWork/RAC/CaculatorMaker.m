//
//  CaculatorMaker.m
//  MyHomeWork
//
//  Created by 凤梨 on 2017/8/3.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import "CaculatorMaker.h"

@implementation CaculatorMaker

- (CaculatorMaker *(^)(int))add {
    return ^CaculatorMaker*(int value){
        _result += value;
        return self;
    };
}
@end
