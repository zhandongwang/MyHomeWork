//
//  DHAllOrderModel.h
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/10.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DHOrderKind;

@interface DHAllOrderModel : NSObject

@property (nonatomic, copy) NSArray <DHOrderKind *> *allOrders;

@end
