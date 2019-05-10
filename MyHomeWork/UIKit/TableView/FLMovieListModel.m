//
//  FLMovieListModel.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/5/9.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLMovieListModel.h"

@implementation FLMovieListModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{@"results":[FLMovieModel class]};
}


@end
