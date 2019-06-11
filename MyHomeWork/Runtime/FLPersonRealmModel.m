//
//  FLPersonRealmModel.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/6/11.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import "FLPersonRealmModel.h"

@implementation FLPersonRealmModel

//+ (NSArray<NSString *> *)ignoredProperties {
//    return @[@"vehicles"];
//}

- (NSString *)description
{
    return [NSString stringWithFormat:@"<%@: %p> userID=%ld, name=%@, age=%ld, salary=%f,birthday=%@,goal=%@,man=%d", [self class], self, self.userID,self.name, self.age, self.salary, self.birthday, self.goal, self.man];
}
- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"<%@: %p> userID=%ld, name=%@, age=%ld, salary=%f,birthday=%@,goal=%@,man=%d", [self class], self, self.userID,self.name, self.age, self.salary, self.birthday, self.goal, self.man];
}


@end
