//
//  DHMessageKinds.m
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/10.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import "DHMessageKinds.h"
#import "DHMessageModel.h"

@implementation DHMessageKinds

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"messages":[DHMessageModel class]
             };
}

@end
