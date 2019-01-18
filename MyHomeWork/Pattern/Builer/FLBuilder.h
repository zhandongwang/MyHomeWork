//
//  FLBuilder.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/1/18.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLBuilderProtocol.h"
#import "FLDoorBuilderProtocol.h"
#import "FLEngineBuilderProtocol.h"
#import "FLWheelBuilderProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLBuilder : NSObject
//所必须具备的子对象
@property (nonatomic, strong) id <FLBuilderProtocol, FLDoorBuilderProtocol> door;
@property (nonatomic, strong) id <FLBuilderProtocol, FLEngineBuilderProtocol> engine;
@property (nonatomic, strong) id <FLBuilderProtocol, FLWheelBuilderProtocol> wheel;

@property (nonatomic, strong) NSDictionary *proInfo;
- (void)buildParts;

@end

NS_ASSUME_NONNULL_END
