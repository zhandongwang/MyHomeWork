//
//  CTFrameParserConfig.h
//  MyHomeWork
//
//  Created by 凤梨 on 2019/4/30.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CTFrameParserConfig : NSObject

//配置属性
@property (nonatomic ,assign)CGFloat width;
@property (nonatomic, assign)CGFloat fontSize;
@property (nonatomic, assign)CGFloat lineSpace;
@property (nonatomic, strong)UIColor *textColor;

@end

NS_ASSUME_NONNULL_END
