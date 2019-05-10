//
//  FLMovieListModel.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/5/9.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLMovieModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FLMovieListModel : NSObject

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSArray<FLMovieModel *> *results;

@end

NS_ASSUME_NONNULL_END
