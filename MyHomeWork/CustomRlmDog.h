//
//  CustomRlmDog.h
//  MyHomeWork
//
//  Created by 王战东 on 2016/11/4.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import <Realm/Realm.h>

@class CustomRlmPerson;

@interface CustomRlmDog : RLMObject

@property NSString *name;
@property NSInteger age;
//@property CustomRlmPerson *owner;

@end

RLM_ARRAY_TYPE(CustomRlmDog)
