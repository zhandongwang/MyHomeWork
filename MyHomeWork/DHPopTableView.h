//
//  DHPopTableView.h
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/9.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DHPopTableView : UIView

/**
 背景遮层alpha,默认值0.7
 */
@property (nonatomic, assign) CGFloat bgAlpha;

/**
 左侧按钮图像，如不提供则不添加edgeButton
 */
@property (nonatomic, strong) UIImage *edgeButtonImage;

/**
 隐藏回调
 */
@property (nonatomic, copy) void(^hiddenBlock)(void);

/**
 初始化方法
 @param frame tableView的frame
 */
- (instancetype)initWithTableViewFrame:(CGRect)frame;


/**
 初始化子views
 */
- (void)initSubViews;

/**
 显示
 */
- (void)show;

@end
