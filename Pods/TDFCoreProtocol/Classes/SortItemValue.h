//
//  SortItemValue.h
//  RestApp
//
//  Created by zishu on 16/8/31.
//  Copyright © 2016年 杭州迪火科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SortItemValue <NSObject>

@property (nonatomic, assign) int sortCode;

-(NSString*) obtainItemId;
@optional
-(NSString*) obtainItemName;
@end

