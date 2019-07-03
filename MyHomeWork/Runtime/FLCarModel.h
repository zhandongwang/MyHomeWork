//
//  FLCar.h
//  MyHomeWork
//
//  Created by 凤梨 on 2018/11/8.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FLPersonModel;

@interface FLCarModel : NSObject

@property (nonatomic, assign) NSString *name;

@property (nonatomic, assign) CGFloat price;



- (void)runTo:(NSString *)place;


@end
