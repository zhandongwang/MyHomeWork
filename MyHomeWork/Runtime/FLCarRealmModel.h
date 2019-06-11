//
//  FLRLMCar.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/6/11.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import "RLMObject.h"
#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLCarRealmModel : RLMObject

@property NSString *name;

@property CGFloat price;

@end
RLM_ARRAY_TYPE(FLRLMCar)

NS_ASSUME_NONNULL_END
