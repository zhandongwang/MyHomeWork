//
//  DHPopTableView.h
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/9.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DHPopTableViewStyle;

@interface DHPopTableView : UIView

/**
 隐藏回调
 */
@property (nonatomic, copy) void(^hiddenBlock)(void);

/**
 初始化方法
 @param frame tableView的frame
 */
- (instancetype)initWithTableViewFrame:(CGRect)frame style:(DHPopTableViewStyle *)style;


/**
 初始化子views
 */
- (void)initSubViews;

/**
 显示
 */
- (void)showWithData:(NSDictionary *)data;


@end
