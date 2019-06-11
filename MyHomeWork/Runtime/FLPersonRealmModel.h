//
//  FLPersonRealmModel.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/6/11.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import "RLMObject.h"
@class FLCarRealmModel;

NS_ASSUME_NONNULL_BEGIN

@interface FLPersonRealmModel : RLMObject

@property FLCarRealmModel *car;

@property NSInteger userID;

@property NSString *name;

@property NSInteger age;

@property CGFloat salary;

@property NSDate *birthday;

@property  NSNumber *goal;

@property  BOOL man;


@end

NS_ASSUME_NONNULL_END
