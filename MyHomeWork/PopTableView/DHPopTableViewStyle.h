//
//  DHPopTableViewStyle.h
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/9.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DHPopTableViewStyle : NSObject

/**
 背景遮层alpha,默认值0.7
 */
@property (nonatomic, assign) CGFloat bgAlpha;


/**
 tableView的wrapperView背景颜色
 */
@property (nonatomic, strong) UIColor *tableWrapperViewBgColor;

/**
 左侧按钮图像，如不提供则不添加edgeButton
 */
@property (nonatomic, strong) UIImage *edgeButtonImage;


/**
 cell的textLabel字号
 */
@property (nonatomic, assign) CGFloat cellTextLableFontSize;

/**
 cell的textLabel字体颜色
 */
@property (nonatomic, strong) UIColor *cellTextLableColor;

@end
