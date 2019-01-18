//
//  FLBuilder.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/1/18.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLBuilder.h"

@implementation FLBuilder

- (void)buildParts {
    //自定义构建顺序
    [self.door build];
    [self.engine build];
    [self.wheel build];
    
    NSMutableDictionary *info = @{}.mutableCopy;
    info[@"door"] = self.door.info;
    info[@"engine"] = self.engine.info;
    info[@"wheel"] = self.wheel.info;
    
    self.proInfo = info;
}

@end
