//
//  ItemSellSelectHandle.h
//  RestApp
//
//  Created by zxh on 14-4-28.
//  Copyright (c) 2014年 杭州迪火科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IImageDataItem.h"

@protocol DHListSelectHandle <NSObject>

-(void) selectObj:(id<IImageDataItem>)obj;

@optional
- (void)categrayButtonAction;

-(void) selectKind:(id<IImageDataItem>)obj;

@end
