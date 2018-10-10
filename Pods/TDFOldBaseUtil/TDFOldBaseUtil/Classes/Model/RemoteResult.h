//
//  RemoteResult.h
//  RestApp
//
//  Created by zxh on 14-4-15.
//  Copyright (c) 2014年 杭州迪火科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RemoteResult : NSObject

@property (nonatomic, strong) NSString *errorStr;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSDictionary* param;
@property (nonatomic, assign) BOOL isSuccess;
@property (nonatomic, assign) BOOL isRedo;

- (id)initSuccessStatus;

@end
