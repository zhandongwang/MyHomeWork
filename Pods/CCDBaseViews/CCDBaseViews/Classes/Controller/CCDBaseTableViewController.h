//
//  CCDBaseTableViewController.h
//  Pods
//
//  Created by 凤梨 on 17/2/23.
//
//

#import <UIKit/UIKit.h>
#import "CCDPageRequestErrorView.h"
#import "CCDPageRequestEmptyView.h"
@import MJRefresh;
@import DZNEmptyDataSet;

/**
 具有空页面、错误页面、可配置下拉刷新、上拉加载的具有透明背景的tableView的管理基类
 子类需要自己实现UITableViewDataSource, UITableViewDelegate的代理方法.
 */

@interface CCDBaseTableViewController : UIViewController
<UITableViewDataSource,
UITableViewDelegate,
DZNEmptyDataSetSource,
DZNEmptyDataSetDelegate>

@property (nonatomic, strong) UITableView *tableView;

/**
 服务器异常view
 */
@property (nonatomic, strong, readonly) CCDPageRequestErrorView *errorView;

/**
 空页面
 */
@property (nonatomic, strong, readonly) CCDPageRequestEmptyView *emptyView;
/**
 tableView数据源
 */
@property (nonatomic, strong) NSMutableArray *dataArray;

/**
  是否使用基类的空页面、错误页面
 */
@property (nonatomic, assign) BOOL useBaseEmptyView;

/**
 是否显示服务器异常页面
 */
@property (nonatomic, assign) BOOL displayErrorView;

/**
 空页面、错误页面偏移量，默认为CGZero
 */
@property (nonatomic, assign) CGFloat emptyViewVerticalOffset;

/**
 添加下拉刷新，子类可选择性调用
 */
- (void)addRefreshHeader;

/**
 添加上拉加载更多，子类可选择性调用
 */
- (void)addRefreshFooter;


- (void)removeRefreshFooter;

- (void)resetNoMoreData;


/**
 结束刷新

 @param noMore 是不是没有更多数据了
 */
- (void)endRefreshWithNoMoreData:(BOOL)noMore;

/**
 请求第一页数据
 */
- (void)sendFirstPageRequest;
/**
 请求下一页数据
 */
- (void)sendNextPageRequest;

/**
 自定义的ErrorView，必须有宽度约束
 */
- (UIView *)customErrorView;

/**
 自定义的EmptyView，必须有宽度约束
 */
- (UIView *)customEmptyView;

- (void)errorViewActionButtonTapped;

- (void)setupLayouts;
@end
