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
 tableView的alpha
 */
@property (nonatomic, assign) CGFloat tableViewAlpha;

/**
 左侧按钮图像，如不提供则不添加edgeButton
 */
@property (nonatomic, strong) UIImage *edgeButtonImage;

@property (nonatomic, strong) UIColor *separatorColor;

@property (nonatomic, assign) CGFloat tableViewRowHeight;

@property (nonatomic, assign) CGFloat sectionHeaderHeight;

@property (nonatomic, assign) CGFloat cellTextLableFontSize;

@property (nonatomic, strong) UIColor *cellTextLableColor;

@end
