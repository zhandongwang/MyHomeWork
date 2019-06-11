//
//  NSObject+RLMHelper.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/6/11.
//  Copyright © 2019 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (RLMHelper)

- (id)ccd_realmModelByClass:(Class)cls;

@end

@protocol RLMHelperProtocol <NSObject>

@optional
+ (nullable NSDictionary<NSString *, NSString*> *)modelCustomRLMPropertyMapper;

+ (nullable NSDictionary<NSString *, Class> *)modelContainerRLMPropertyGenericClass;

@end

NS_ASSUME_NONNULL_END
