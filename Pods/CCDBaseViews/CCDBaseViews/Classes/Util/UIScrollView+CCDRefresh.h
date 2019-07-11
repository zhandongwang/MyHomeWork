//
//  UIScrollView+CCDRefresh.h
//  CCDBaseViews
//
//  Created by 凤梨 on 2017/10/12.
//

#import <UIKit/UIKit.h>
@interface UIScrollView (CCDRefresh)

- (void)ccd_AddRefreshHeaderWithRefreshingTarget:(id)target selector:(SEL)refreshingSelector;

- (void)ccd_AddRefreshFooterWithRefreshingTarget:(id)target selector:(SEL)refreshingSelector;

- (void)ccd_RemoveRefreshFooter;

/** 重置没有更多的数据（消除没有更多数据的状态） */
- (void)ccd_ResetNoMoreData;
/** 根据noMore，提示没有更多的数据 */
- (void)ccd_EndRefreshWithNoMoreData:(BOOL)noMore;

@end
