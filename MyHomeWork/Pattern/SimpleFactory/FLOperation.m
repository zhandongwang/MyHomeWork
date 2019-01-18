//
//  FLOperation.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/1/18.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLOperation.h"

@implementation FLOperation

-(CGFloat)getResult {
    return 0.0;
}

@end

@implementation FLOperationAdd

- (CGFloat)getResult {
    return self.numberA + self.numberB;
}

@end

@implementation FLOperationSub

- (CGFloat)getResult {
    return self.numberA - self.numberB;
}

@end

@implementation FLOperationMul

- (CGFloat)getResult {
    return self.numberA * self.numberB;
}

@end

@implementation FLOperationDiv

- (CGFloat)getResult {
    if (self.numberB == 0) {
        [NSException raise:@"MyException" format:@"除数不能为0"];
    }
    return self.numberA / self.numberB;
}

@end
