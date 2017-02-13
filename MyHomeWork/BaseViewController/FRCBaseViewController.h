//
//  FRCBaseViewController.h
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/13.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FRCBaseViewController : UIViewController

@property (nonatomic, strong) UIImage *bgImage;


/**
 请求第一页数据
 */
- (void)sendFirstPageRequet;
/**
 请求下一页数据
 */
- (void)sendNextPageRequet;


/**
 给tabelView添加下拉刷下和上拉加载更多

 */
- (void)addRefreshToTableView:(UITableView *)tableView;

/**
 给tabelView添加下拉刷新，不立即开始下拉刷新
 
 */
- (void)addRefreshHeaderToTableView:(UITableView *)tableView;


/**
 给tabelView添加下拉刷新
 @param beginRefresh 是否立即开始下拉刷新
 */
- (void)addRefreshHeaderToTableView:(UITableView *)tableView beginRefresh:(BOOL)beginRefresh;


/**
 给tabelView添加上拉加载更多
 */
- (void)addRefreshFooterToTableView:(UITableView *)tableView;

@end
