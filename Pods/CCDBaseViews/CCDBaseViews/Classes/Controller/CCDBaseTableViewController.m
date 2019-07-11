//
//  CCDBaseTableViewController.m
//  Pods
//
//  Created by 凤梨 on 17/2/23.
//
//

#import "CCDBaseTableViewController.h"
#import "UIScrollView+CCDRefresh.h"
#import "CCDBaseViewsConst.h"
@import Masonry;
@import TDFBundle;

@interface CCDBaseTableViewController ()

@property (nonatomic, strong, readwrite) CCDPageRequestErrorView *errorView;

@property (nonatomic, strong, readwrite) CCDPageRequestEmptyView *emptyView;

@end

@implementation CCDBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)setup {
    [self setupViews];
    [self setupLayouts];
}

- (void)setupViews {
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView = [[UITableView alloc] init];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    if(@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
    self.dataArray = [[NSMutableArray alloc] initWithCapacity:10];
    [self.view addSubview:self.tableView];
}

- (void)setupLayouts {
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - DZNEmptyDataSetSource

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.displayErrorView) {
        return [self customErrorView];
    } else {
        return [self customEmptyView];
    }
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return self.emptyViewVerticalOffset;
}

#pragma mark - DZNEmptyDataSetDelegate 

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
{
    if (!self.useBaseEmptyView) {
        return NO;
    }

    if (self.dataArray.count == 0) {
        self.errorView.hidden = NO;
        self.emptyView.hidden = NO;

        return YES;
    }
    return NO;
}

#pragma mark - public methods
- (void)sendFirstPageRequest {
}

- (void)sendNextPageRequest {
}

- (UIView *)customErrorView {
    return self.errorView;
}

- (UIView *)customEmptyView {
    return self.emptyView;
}

- (void)addRefreshHeader {
    [self.tableView ccd_AddRefreshHeaderWithRefreshingTarget:self selector:@selector(sendFirstPageRequest)];
}

- (void)addRefreshFooter {
    [self.tableView ccd_AddRefreshFooterWithRefreshingTarget:self selector:@selector(sendNextPageRequest)];
}

- (void)removeRefreshFooter {
    [self.tableView ccd_RemoveRefreshFooter];
}

- (void)resetNoMoreData {
    [self.tableView ccd_ResetNoMoreData];
}

- (void)endRefreshWithNoMoreData:(BOOL)noMore {
    [self.tableView ccd_EndRefreshWithNoMoreData:noMore];
}

- (void)errorViewActionButtonTapped {
    self.errorView.hidden = YES;
}

#pragma mark - accessors

- (CCDPageRequestErrorView *)errorView {
    if (!_errorView) {
        _errorView = [[CCDPageRequestErrorView alloc] init];
        _errorView.iconImageView.image = TDFImageFromBundle(@"serverError", [CCDBaseViewsConst class]);
        __weak __typeof(self)weakSelf = self;
        _errorView.actionButtonTappedBlock = ^{
            [weakSelf errorViewActionButtonTapped];
        };
    }
    return _errorView;
}

- (CCDPageRequestEmptyView *)emptyView {
    if (!_emptyView) {
        _emptyView = [[CCDPageRequestEmptyView alloc] initWithFrame:self.view.frame image:nil title:TDFLocalizedStringFromBundle(@"emptyData", [CCDBaseViewsConst class], @"没有数据")];
    }
    return _emptyView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
