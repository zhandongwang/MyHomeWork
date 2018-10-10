//
//  BaseEntity.m
//  CardApp
//
//  Created by SHAOJIANQING-MAC on 13-6-19.
//  Copyright (c) 2013年 ZMSOFT. All rights reserved.
//

#import "EntityObject.h"

@implementation EntityObject
@synthesize entityId;

-(void)dealloc{
    self.entityId=nil;
}
@end
