//
//  RACRequest.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/1/2.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
NS_ASSUME_NONNULL_BEGIN

@interface RACRequest : NSObject

+ (RACSignal *)loginWithUserName:(NSString *)name password:(NSString *)password;
@end

NS_ASSUME_NONNULL_END
