//
//  FLUIKitTableViewControllerViewModel.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/5/9.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FLUIKitTableViewControllerViewModel : NSObject

+ (instancetype)sharedInstance;
- (NSArray*)getDiscoverList:(NSString *)pageLimit;

@end

NS_ASSUME_NONNULL_END
