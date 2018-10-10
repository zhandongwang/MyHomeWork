//
//  MultiCheckHandle.h
//  RestApp
//
//  Created by zxh on 14-4-23.
//  Copyright (c) 2014年 杭州迪火科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INameItem.h"
#import "INameValueItem.h"

@protocol MultiCheckHandle <NSObject>

- (void)multiCheck:(NSInteger)event items:(NSMutableArray*)items;
- (void)multiCheck:(NSInteger)event item:(id<INameItem>) item;
- (void)closeMultiView:(NSInteger)event;

@end
