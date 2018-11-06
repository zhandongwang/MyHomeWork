//
//  JSPerson.m
//  MyHomeWork
//
//  Created by 凤梨 on 2018/10/30.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

#import "JSPerson.h"

@implementation JSPerson

- (NSString *)fullName {
    return [NSString stringWithFormat:@"%@:%@", self.firstName, self.secondName];
}

- (NSString *)sayFullName {
    NSLog(@"%@",self.fullName);
    return self.fullName;
}

- (void)evaluatePrice {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"EvaluatePrice" ofType:@"js"];
    NSString *js = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    JSContext *context = [[JSContext alloc] init];
    JSValue *value = [context evaluateScript:js];
    int intValue = [value toInt32];
    NSLog(@"计算结果为%d", intValue);
}

@end
