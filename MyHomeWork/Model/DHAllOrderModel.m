//
//  DHAllOrderModel.m
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/10.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import "DHAllOrderModel.h"
#import "DHOrderKind.h"

@implementation DHAllOrderModel


+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"allOrders":[DHOrderKind class]
             };
}




@end
