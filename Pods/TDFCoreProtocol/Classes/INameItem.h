//
//  INameItem.h
//  RestApp
//
//  Created by zxh on 14-4-6.
//  Copyright (c) 2014年 杭州迪火科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol INameItem <NSObject>

@required
- (NSString *)obtainItemId;

- (NSString *)obtainItemName;

- (NSString *)obtainOrignName;

@optional
-(NSString*) obtainItemValue;

//供应链
- (NSString *)obtainLinkName;

- (NSString *)obtainEntityId;

- (NSString *)obtainCode;

- (NSString *)obtainWarehouseId;

@end
