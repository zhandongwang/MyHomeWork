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

@property (nonatomic, strong) UITableView *contentTableView;

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
 初始化子views，调用此方法后才可以自定义contentTableView其它属性
 */
- (void)initSubViews;


/**
 展示

 @param sectionData section数据源
 @param data 完整数据源，如果只有一个section且不要section则设置key为@""
 */
- (void)showWithSectionData:(NSArray *)sectionData fullData:(NSDictionary *)data;


@end
