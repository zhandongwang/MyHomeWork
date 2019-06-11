//
//  FLPerson.h
//  MyHomeWork
//
//  Created by 凤梨 on 2018/11/8.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>


@class FLCarModel;
@interface FLPersonModel : NSObject


@property (nonatomic, strong) FLCarModel *car;

@property (nonatomic, strong) NSNumber *goal;

@property (nonatomic, assign) NSInteger userID;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, assign) CGFloat salary;

@property (nonatomic, strong) NSDate *birthday;



@property (nonatomic, assign) BOOL man;

- (void)runTo:(NSString *)place;

@end
