//
//  FLDoorBuilderProtocol.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/1/18.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//
#import <Foundation/Foundation.h>

#ifndef FLDoorBuilderProtocol_h
#define FLDoorBuilderProtocol_h

@protocol FLDoorBuilderProtocol <NSObject>

- (void)doorColor:(UIColor *)color;

- (NSString *)info;

@end

#endif /* FLDoorBuilderProtocol_h */
