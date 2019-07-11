//
//  UIScrollView+CCDRefresh.m
//  CCDBaseViews
//
//  Created by 凤梨 on 2017/10/12.
//

#import "UIScrollView+CCDRefresh.h"
#import "CCDBaseViewController.h"
@import MJRefresh;
@import TDFBundle;
@implementation UIScrollView (CCDRefresh)

- (void)ccd_AddRefreshHeaderWithRefreshingTarget:(id)target selector:(SEL)refreshingSelector {
    if (!self.header) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:refreshingSelector];
        header.stateLabel.textColor = [UIColor whiteColor];
        header.lastUpdatedTimeLabel.hidden = YES;
        [header setTitle:@"" forState:MJRefreshStateIdle];
        [header setTitle:TDFLocalizedStringFromBundle(@"ready4Refresh", [CCDBaseViewController class], @"") forState:MJRefreshStatePulling];
        [header setTitle:TDFLocalizedStringFromBundle(@"refreshing", [CCDBaseViewController class], @"") forState:MJRefreshStateRefreshing];
        header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        
        self.header = header;
    }
}

- (void)ccd_AddRefreshFooterWithRefreshingTarget:(id)target selector:(SEL)refreshingSelector {
    if (!self.footer) {
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:refreshingSelector];
        footer.stateLabel.textColor = [UIColor whiteColor];
        [footer setTitle:@"" forState:MJRefreshStateIdle];
        [footer setTitle:TDFLocalizedStringFromBundle(@"noMoreData", [CCDBaseViewController class], @"") forState:MJRefreshStateNoMoreData];
        [footer setTitle:TDFLocalizedStringFromBundle(@"isloading", [CCDBaseViewController class], @"加载中...") forState:MJRefreshStateRefreshing];
        footer.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        self.footer = footer;
    }
}

- (void)ccd_RemoveRefreshFooter {
    self.footer = nil;
}

- (void)ccd_ResetNoMoreData {
    [self.footer resetNoMoreData];
}

- (void)ccd_EndRefreshWithNoMoreData:(BOOL)noMore {
    if (noMore) {
        [self.footer endRefreshingWithNoMoreData];
    } else {
        [self.footer endRefreshing];
    }
    
    if (self.header.state != MJRefreshStateIdle) {
        [self.header endRefreshing];
    }
}

@end
