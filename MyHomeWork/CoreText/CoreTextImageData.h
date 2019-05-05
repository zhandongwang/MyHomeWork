//
//  CoreTextImageData.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/5/5.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CoreTextImageData : NSObject

//图片资源名称
@property (copy,nonatomic)NSString *name;
//图片位置的起始点
@property (assign,nonatomic)CGFloat position;
//图片的尺寸
@property (assign,nonatomic)CGRect imagePostion;

@end

NS_ASSUME_NONNULL_END
