//
//  DHUserModel.h
//  MyHomeWork
//
//  Created by 凤梨 on 2018/9/25.
//  Copyright © 2018年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHUserModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSURL *picUrl;
@property (nonatomic, strong) NSNumber *score;
@property (nonatomic, assign) long age;
@property (nonatomic, copy) NSString *address;

@end
