//
//  FRCBaseViewController.m
//  MyHomeWork
//
//  Created by 凤梨 on 17/2/13.
//  Copyright © 2017年 zhandongwang. All rights reserved.
//

#import "FRCBaseViewController.h"
#import "UIViewController+DHRouter.h"

@interface FRCBaseViewController ()

@end

@implementation FRCBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //URL管理VC，将params自动赋值给属性,暂时没有参数校验
    [self.routerParams enumerateKeysAndObjectsUsingBlock:^(NSString *key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (![key isEqualToString:@"controller_class"]) {
         [self setValue:obj forKey:key];
        }
    }];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [bgImageView setImage:self.bgImage];
    [self.view addSubview:bgImageView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - event handler

- (void)sendFirstPageRequet {
}

- (void)sendNextPageRequet {
}


#pragma mark - public methods

- (void)addRefreshToTableView:(UITableView *)tableView {
    [self addRefreshHeaderToTableView:tableView beginRefresh:NO];
    [self addRefreshFooterToTableView:tableView];
}

- (void)addRefreshHeaderToTableView:(UITableView *)tableView {
    [self addRefreshHeaderToTableView:tableView beginRefresh:NO];
}

- (void)addRefreshHeaderToTableView:(UITableView *)tableView beginRefresh:(BOOL)beginRefresh {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(sendFirstPageRequet)];
    header.stateLabel.textColor = [UIColor whiteColor];
    header.lastUpdatedTimeLabel.hidden = YES;
    header.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    
    if (beginRefresh) {
        [header beginRefreshing];
    }
    tableView.header = header;
}

- (void)addRefreshFooterToTableView:(UITableView *)tableView {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(sendNextPageRequet)];
    footer.stateLabel.textColor = [UIColor whiteColor];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    footer.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    
    tableView.footer = footer;
    
}

- (void)resetNoMoreData:(UITableView *)tableView
{
    [tableView.footer resetNoMoreData];
}

- (void)endRefreshToTableView:(UITableView *)tableView {
    [tableView.header endRefreshing];
    [tableView.footer endRefreshing];
}

@end
