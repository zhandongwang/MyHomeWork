//
//  SingleCheckDelegate.h
//  RestApp
//
//  Created by zxh on 14-4-6.
//  Copyright (c) 2014年 杭州迪火科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INameItem.h"
#import "INameValueItem.h"

@protocol SingleCheckHandle<NSObject>

- (void)singleCheck:(NSInteger)event item:(id<INameItem>) item;

- (void)closeSingleView:(NSInteger)event;
@optional
- (void)singleCheckWithEvent:(NSInteger)event item:(id<INameValueItem>) item;
@end
