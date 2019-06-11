//
//  FLPerson.m
//  MyHomeWork
//
//  Created by 凤梨 on 2018/11/8.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

#import "FLPersonModel.h"
#import "FLCarModel.h"

@implementation FLPersonModel

+ (nullable NSDictionary<NSString *, Class> *)modelContainerRLMPropertyGenericClass {
    return @{@"vehicles": [FLCarModel class]};
}

- (void)runTo:(NSString *)place {
    NSLog(@"FLPerson %@", place);
}

+ (nullable NSDictionary<NSString *, NSString *> *)propertyCustomDBMapper {
    return @{@"name":@"personName"};
}

+ (nullable NSArray<NSString *> *)primaryKeys{
    return @[@"userID"];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@:%p, name = %@, age = %ld, salary = %f, birthday = %@",[self class],self,_name,(long)_age,_salary,_birthday];
}


- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"%@:%p, name = %@, age = %ld, salary = %f, birthday = %@",[self class],self,_name,(long)_age,_salary,_birthday];
}

@end
