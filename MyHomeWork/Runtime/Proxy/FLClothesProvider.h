//
//  FLClothesProvider.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/2/14.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLClothesProviderProtocol <NSObject>

- (void)purchaseCloseWithSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_BEGIN

@interface FLClothesProvider : NSObject

//- (void)purchaseCloseWithSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
