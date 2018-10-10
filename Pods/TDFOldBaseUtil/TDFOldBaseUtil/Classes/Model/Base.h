//
//  Base.h
//  RestApp
//
//  Created by zxh on 14-3-25.
//  Copyright (c) 2014年 杭州迪火科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BASE_TRUE 1
#define BASE_FALSE 0

#define _DEBUG 3

@interface Base : NSObject

////   操作人.
//@property (nonatomic, strong) NSString *opUser;

 //   ID.
@property (nonatomic, strong) NSString *_id;
@property (nonatomic, strong) NSString *id;

//   版本号.
@property (nonatomic, assign) int lastVer;

//   记录创建时间.
@property (nonatomic, assign) long createTime;

//   修改时间.
@property (nonatomic, assign) long opTime;

//   是否有效.
@property (nonatomic, assign) int isValid;

@end
