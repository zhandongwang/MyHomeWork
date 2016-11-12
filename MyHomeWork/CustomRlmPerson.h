//
//  CustomRlmPerson.h
//  MyHomeWork
//
//  Created by 王战东 on 2016/11/4.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import <Realm/Realm.h>
#import "CustomRlmDog.h"

@interface CustomRlmPerson : RLMObject

@property NSString *name;
@property NSInteger age;
@property RLMArray <CustomRlmDog *> <CustomRlmDog> *dogs;

@end

RLM_ARRAY_TYPE(CustomRlmPerson)

