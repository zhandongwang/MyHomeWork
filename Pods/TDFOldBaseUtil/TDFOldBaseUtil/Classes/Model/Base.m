//
//  Base.m
//  RestApp
//
//  Created by zxh on 14-3-25.
//  Copyright (c) 2014年 杭州迪火科技有限公司. All rights reserved.
//

#import "Base.h"
#import "ObjectUtil.h"
#import "NSString+Estimate.h"

@implementation Base

//@synthesize opUser;
@synthesize _id;
@synthesize id;
@synthesize lastVer;
@synthesize isValid;
@synthesize createTime;
@synthesize opTime;

- (NSString *)_id {
    if(_id == [NSNull null] || _id == nil) {
        _id = self.id;
    }
    return _id;
}

@end
