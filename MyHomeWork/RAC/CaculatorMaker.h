//
//  CaculatorMaker.h
//  MyHomeWork
//
//  Created by 凤梨 on 2017/8/3.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaculatorMaker : NSObject

@property (nonatomic, assign) int result;

- (CaculatorMaker *(^)(int))add;


@end
