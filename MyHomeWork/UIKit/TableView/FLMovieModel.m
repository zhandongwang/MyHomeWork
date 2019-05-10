//
//  FLMovieModel.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/5/9.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLMovieModel.h"
#import "YYModel.h"

@implementation FLMovieModel

+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{@"picPath":@"poster_path"};
}

@end
