//
//  RLMPerson.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/5/31.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@class FLRLMCar;

NS_ASSUME_NONNULL_BEGIN

@interface FLRLMPersonModel : RLMObject

@property FLRLMCar *car;

@property NSInteger userID;

@property NSString *sex;

@property NSString *name;

@property  NSInteger age;

@property float salary;

@property NSDate *birthday;

@property BOOL man;

@property NSNumber<RLMDouble> *goal;

@end

NS_ASSUME_NONNULL_END


