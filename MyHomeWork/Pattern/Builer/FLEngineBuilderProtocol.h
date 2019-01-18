//
//  FLEngineBuilderProtocol.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/1/18.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef FLEngineBuilderProtocol_h
#define FLEngineBuilderProtocol_h

@protocol FLEngineBuilderProtocol <NSObject>

- (void)engineWeight:(CGFloat)weight;

- (NSString *)info;

@end


#endif /* FLEngineBuilderProtocol_h */
