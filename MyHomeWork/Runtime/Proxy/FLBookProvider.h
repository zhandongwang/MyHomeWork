//
//  FLBookProvider.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/2/14.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLBookProviderProtocol <NSObject>

- (void)purchaseBookWithTitle:(NSString *)title;

@end


NS_ASSUME_NONNULL_BEGIN

@interface FLBookProvider : NSObject

//- (void)purchaseBookWithTitle:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
